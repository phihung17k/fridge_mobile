import 'package:fridge_mobile/data/models/ingredient_model.dart';

import '../../paging_result.dart';

abstract class IIngredientService {
  Future<PagingResult<IngredientModel>?> getIngredients();
  // Future<Ingredient> getIngredient(String id);
  // Future<Ingredient> addIngredient(Ingredient ingredient);
  // Future<Ingredient> updateIngredient(Ingredient ingredient);
  // Future<void> deleteIngredient(String id);
}
