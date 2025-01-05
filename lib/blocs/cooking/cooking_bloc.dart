import 'package:fridge_mobile/blocs/base_bloc.dart';
import 'package:fridge_mobile/data/services/ingredient/i_ingredient_service.dart';

import '../../data/models/ingredient_model.dart';
import '../../data/paging_result.dart';
import 'cooking_state.dart';

class CookingBloc extends BaseBloc<CookingState> {
  final IIngredientService ingredientService;

  CookingBloc(this.ingredientService) : super(const CookingState(ingredients: []));

  Stream<List<IngredientModel>> get ingredientListStream =>
      stateStream.map((state) => state.ingredients!).distinct();

  void getIngredients() async {
    load(true);
    PagingResult<IngredientModel>? ingredients = await ingredientService.getIngredients();
    emit(state.copyWith(ingredients: ingredients?.items));
    load(false);
  }
}
