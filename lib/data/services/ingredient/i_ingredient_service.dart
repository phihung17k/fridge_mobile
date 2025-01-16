import 'package:fridge_mobile/data/models/ingredient_model.dart';
import 'package:fridge_mobile/data/models/selected_ingredient_model.dart';

import '../../paging_result.dart';

abstract class IIngredientService {
  Future<PagingResult<IngredientModel>?> getIngredients(int? pageIndex);
  Future<PagingResult<SelectableIngredientModel>?> getSelectableIngredients(int? pageIndex);
  // Future<Ingredient> getIngredient(String id);
  // Future<Ingredient> addIngredient(Ingredient ingredient);
  // Future<Ingredient> updateIngredient(Ingredient ingredient);
  // Future<void> deleteIngredient(String id);
}
