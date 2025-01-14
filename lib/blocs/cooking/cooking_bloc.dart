import 'dart:developer';

import 'package:fridge_mobile/blocs/base_bloc.dart';
import 'package:fridge_mobile/data/services/ingredient/i_ingredient_service.dart';

import '../../data/models/ingredient_model.dart';
import '../../data/paging_result.dart';
import 'cooking_state.dart';

class CookingBloc extends BaseBloc<CookingState> {
  final IIngredientService ingredientService;

  CookingBloc(this.ingredientService)
      : super(const CookingState(
          ingredients: [],
          pageIndex: 1,
          isLoadMore: false,
        ));

  Stream<List<IngredientModel>> get ingredientListStream =>
      stateStream.map((state) => state.ingredients!).distinct();

  Stream<bool> get isLoadMoreStream => stateStream.map((state) => state.isLoadMore!).distinct();

  void getIngredients({int? pageIndex}) async {
    if (state.hasNext == false) {
      return;
    }
    log("LOAD MORE - current page index: ${state.pageIndex}");
    // load(true);
    emit(state.copyWith(
      isLoadMore: true,
    ));

    PagingResult<IngredientModel>? ingredientsPageResult = await Future.delayed(
      const Duration(seconds: 1),
      () => ingredientService.getIngredients(pageIndex ?? state.pageIndex! + 1),
    );
    // PagingResult<IngredientModel>? ingredientsPageResult =
    //     await ingredientService.getIngredients(pageIndex ?? state.pageIndex! + 1);

    if (ingredientsPageResult == null) {
      // load(false);
      emit(state.copyWith(
        isLoadMore: false,
      ));
      return;
    }

    List<IngredientModel> items = state.ingredients!.toList();
    items.addAll(ingredientsPageResult.items);
    // load(false);
    emit(state.copyWith(
      ingredients: items,
      hasNext: ingredientsPageResult.hasNext,
      pageIndex: ingredientsPageResult.pageIndex,
      isLoadMore: false,
    ));
  }
}
