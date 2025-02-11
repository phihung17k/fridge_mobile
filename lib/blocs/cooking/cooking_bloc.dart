// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:fridge_mobile/blocs/base_bloc.dart';
import 'package:fridge_mobile/data/models/selectable_ingredient_model.dart';
import 'package:fridge_mobile/data/models/selectable_ingredient_model_wrapper.dart';
import 'package:fridge_mobile/data/request/ingredient_paging_request.dart';
import 'package:fridge_mobile/data/services/category/i_category_service.dart';
import 'package:fridge_mobile/data/services/ingredient/i_ingredient_service.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import '../../data/models/category_model.dart';
import '../../data/paging_result.dart';
import 'cooking_state.dart';

class CookingBloc extends BaseBloc<CookingState> {
  final IIngredientService ingredientService;
  final ICategoryService categoryService;

  CookingBloc(this.ingredientService, this.categoryService) : super(CookingState.empty());

  Stream<List<SelectableIngredientModel>> get ingredientListStream =>
      stateStream.map((state) => state.ingredients!).distinct();

  Stream<bool> get isLoadMoreStream => stateStream.map((state) => state.isLoadMore!).distinct();
  Stream<bool> get waitGettingIngredientsStream =>
      stateStream.map((state) => state.waitGettingIngredients!).distinct();

  Stream<(List<SelectableIngredientModel>, bool, bool)>
      get ingredients_waitGettingIngredients_loadmoreStream => Rx.combineLatest3(
          ingredientListStream,
          waitGettingIngredientsStream,
          isLoadMoreStream,
          (a, b, c) => (a, b, c)).distinct();

  Stream<List<CategoryModel>> get categoriesStream =>
      stateStream.map((state) => state.categories!).distinct();

  Stream<int?> get selectedCategoryIdStream =>
      stateStream.map((state) => state.selectedCategoryId).distinct();

  Stream<(List<CategoryModel>, int?, bool)>
      get categories_selectedCategoryId_waitGettingIngredientsStream => Rx.combineLatest3(
          categoriesStream,
          selectedCategoryIdStream,
          waitGettingIngredientsStream,
          (a, b, c) => (a, b, c)).distinct();

  /// get All category
  void getAllCategory() async {
    List<CategoryModel>? categories = await categoryService.getAllCategory();
    emit(state.copyWith(categories: categories ?? []));
  }

  /// get ingredient at the first time trigger cooking page
  void getIngredientsWithCategory({int? categoryId}) async {
    // case categoryId is not inputted, call ingredient for all categories
    categoryId ??= 0;
    emit(state.copyWith(
      ingredients: [],
      // hasNext: false,
      // pageIndex: 1,
      selectedCategoryId: categoryId,
      waitGettingIngredients: true,
    ));

    PagingResult<SelectableIngredientModel>? ingredientsPageResult;
    // case category is exist in map
    if (state.categoryIngredientsMap!.containsKey(categoryId)) {
      // get the first 10 items by category
      // List<SelectableIngredientModel> ingredients =
      //     state.categoryIngredientsMap![categoryId]!.ingredients!.take(10).toList();

      emit(state.copyWith(
        ingredients: state.categoryIngredientsMap![categoryId]!.ingredients,
        // hasNext: true,
        // pageIndex: 1,
        waitGettingIngredients: false,
      ));

      return;
    }

    // call API when category is NOT exist
    ingredientsPageResult = await Future.delayed(const Duration(seconds: 1), () {
      return ingredientService
          .getSelectableIngredients(IngredientPagingRequest(categoryId: categoryId));
    });

    if (ingredientsPageResult == null) {
      // log("ingredientsPageResult == null");
      emit(state.copyWith(
        waitGettingIngredients: false,
      ));
      return;
    }

    // add ingredients by category id in map
    Map<int, SelectableIngredientModelWrapper?>? newMap = Map.from(state.categoryIngredientsMap!);
    // if (newMap.containsKey(categoryId)) {
    //   SelectableIngredientModelWrapper wrapper = newMap[categoryId]!;
    //   newMap[categoryId] = wrapper.copyWith(
    //     ingredients: wrapper.ingredients! + ingredientsPageResult.items,
    //     hasNext: ingredientsPageResult.hasNext,
    //     pageIndex: ingredientsPageResult.pageIndex,
    //   );
    // } else {
    newMap[categoryId] = SelectableIngredientModelWrapper(
      // categoryId: categoryId,
      ingredients: ingredientsPageResult.items,
      hasNext: ingredientsPageResult.hasNext,
      pageIndex: ingredientsPageResult.pageIndex,
      scrollPosition: 0,
    );
    // }

    emit(state.copyWith(
      categoryIngredientsMap: newMap,
      ingredients: newMap[categoryId]!.ingredients,
      // hasNext: ingredientsPageResult.hasNext,
      // pageIndex: ingredientsPageResult.pageIndex,
      waitGettingIngredients: false,
    ));
  }

  /// get ingredient with page index
  void loadMoreIngredients() async {
    SelectableIngredientModelWrapper wrapper =
        state.categoryIngredientsMap![state.selectedCategoryId]!;
    if (wrapper.hasNext == false) {
      return;
    }
    // log("LOAD MORE - current page index: ${state.pageIndex}");
    emit(state.copyWith(
      isLoadMore: true,
    ));

    PagingResult<SelectableIngredientModel>? ingredientsPageResult = await Future.delayed(
      const Duration(seconds: 1),
      () => ingredientService.getSelectableIngredients(IngredientPagingRequest(
        pageIndex: wrapper.pageIndex! + 1,
        categoryId: state.selectedCategoryId,
      )),
    );

    if (ingredientsPageResult == null || ingredientsPageResult.items.isEmpty) {
      emit(state.copyWith(
        isLoadMore: false,
      ));
      return;
    }

    // load more
    // case All : category id = 0
    // case specific category id
    //  - call API to get new ingredient
    //    + Error / empty: no change
    //    + Have data: add data to map

    // add ingredients by category id in map <id, ingredients>
    Map<int, SelectableIngredientModelWrapper?>? newMap = Map.from(state.categoryIngredientsMap!);
    // for (SelectableIngredientModel ingredient in ingredientsPageResult.items) {
    //   newMap.putIfAbsent(ingredient.category!.id!, () => [])!.add(ingredient);
    // }

    newMap[state.selectedCategoryId!] = wrapper.copyWith(
      ingredients: wrapper.ingredients! + ingredientsPageResult.items,
      hasNext: ingredientsPageResult.hasNext,
      pageIndex: ingredientsPageResult.pageIndex,
    );

    emit(state.copyWith(
      categoryIngredientsMap: newMap,
      ingredients: newMap[state.selectedCategoryId!]!.ingredients,
      isLoadMore: false,
    ));
  }

  void selectIngredient(int index) {
    List<SelectableIngredientModel> items = state.ingredients!.toList();
    SelectableIngredientModel ingredient = items[index];
    items[index] = ingredient.copyWith(isSelected: !ingredient.isSelected);
    emit(state.copyWith(ingredients: items));
  }
}
