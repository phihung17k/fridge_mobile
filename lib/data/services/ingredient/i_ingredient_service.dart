import 'package:fridge_mobile/data/models/ingredient_model.dart';
import 'package:fridge_mobile/data/models/selectable_ingredient_model.dart';
import 'package:fridge_mobile/data/request/ingredient_paging_request.dart';

import '../../paging_result.dart';

abstract class IIngredientService {
  // Future<PagingResult<IngredientModel>?> getIngredients(int? pageIndex);
  Future<PagingResult<SelectableIngredientModel>?> getSelectableIngredients(
      IngredientPagingRequest request);
  // Future<PagingResult<SelectableIngredientModel>?> getSelectableIngredientsByCategoryId({
  //   int categoryId = 0,
  //   int? pageIndex,
  // });
  // Future<Ingredient> getIngredient(String id);
  // Future<Ingredient> addIngredient(Ingredient ingredient);
  // Future<Ingredient> updateIngredient(Ingredient ingredient);
  // Future<void> deleteIngredient(String id);
}
