import 'package:fridge_mobile/blocs/base_bloc.dart';
import 'package:fridge_mobile/data/services/ingredient/i_ingredient_service.dart';

import '../../data/models/ingredient_model.dart';
import '../../data/paging_result.dart';
import 'cooking_state.dart';

class CookingBloc extends BaseBloc<CookingState> {
  final IIngredientService ingredientService;

  CookingBloc(this.ingredientService) : super(const CookingState(ingredients: [], pageIndex: 1));

  Stream<List<IngredientModel>> get ingredientListStream =>
      stateStream.map((state) => state.ingredients!).distinct();

  void getIngredients() async {
    if (state.hasNext == false) {
      return;
    }

    load(true);
    PagingResult<IngredientModel>? ingredientsPageResult =
        await ingredientService.getIngredients(state.pageIndex! + 1);

    if (ingredientsPageResult == null) {
      load(false);
      return;
    }

    List<IngredientModel> items = state.ingredients!.toList();
    items.addAll(ingredientsPageResult.items);
    emit(state.copyWith(
      ingredients: items,
      hasNext: ingredientsPageResult.hasNext,
      pageIndex: ingredientsPageResult.pageIndex,
    ));
    load(false);
  }
}
