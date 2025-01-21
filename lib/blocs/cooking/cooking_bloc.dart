import 'dart:developer';
import 'package:fridge_mobile/blocs/base_bloc.dart';
import 'package:fridge_mobile/data/models/selected_ingredient_model.dart';
import 'package:fridge_mobile/data/services/category/i_category_service.dart';
import 'package:fridge_mobile/data/services/ingredient/i_ingredient_service.dart';
import 'package:rxdart/rxdart.dart';
import '../../data/models/category_model.dart';
import '../../data/paging_result.dart';
import 'cooking_state.dart';

class CookingBloc extends BaseBloc<CookingState> {
  final IIngredientService ingredientService;
  final ICategoryService categoryService;

  CookingBloc(this.ingredientService, this.categoryService)
      : super(const CookingState(
          ingredients: [],
          pageIndex: 1,
          isLoadMore: false,
          categories: [],
        ));

  Stream<List<SelectableIngredientModel>> get ingredientListStream =>
      stateStream.map((state) => state.ingredients!).distinct();

  Stream<bool> get isLoadMoreStream => stateStream.map((state) => state.isLoadMore!).distinct();

  Stream<(List<SelectableIngredientModel>, bool)> get ingredientsAndLoadmoreStream =>
      Rx.combineLatest2(ingredientListStream, isLoadMoreStream, (a, b) => (a, b)).distinct();

  Stream<List<CategoryModel>> get categoriesStream =>
      stateStream.map((state) => state.categories!).distinct();

  void getIngredients({int? pageIndex}) async {
    if (state.hasNext == false) {
      return;
    }
    // log("LOAD MORE - current page index: ${state.pageIndex}");
    emit(state.copyWith(
      isLoadMore: true,
    ));

    PagingResult<SelectableIngredientModel>? ingredientsPageResult = await Future.delayed(
      const Duration(seconds: 1),
      () => ingredientService.getSelectableIngredients(pageIndex ?? state.pageIndex! + 1),
    );

    if (ingredientsPageResult == null) {
      emit(state.copyWith(
        isLoadMore: false,
      ));
      return;
    }

    List<SelectableIngredientModel> items = state.ingredients!.toList();
    items.addAll(ingredientsPageResult.items);
    emit(state.copyWith(
      ingredients: items,
      hasNext: ingredientsPageResult.hasNext,
      pageIndex: ingredientsPageResult.pageIndex,
      isLoadMore: false,
    ));
  }

  void selectIngredient(int index) {
    List<SelectableIngredientModel> items = state.ingredients!.toList();
    SelectableIngredientModel ingredient = items[index];
    items[index] = ingredient.copyWith(isSelected: !ingredient.isSelected);
    emit(state.copyWith(ingredients: items));
  }

  void getAllCategory() async {
    List<CategoryModel>? categories = await categoryService.getAllCategory();
    emit(state.copyWith(categories: categories ?? []));
  }
}
