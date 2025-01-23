import 'package:fridge_mobile/data/response/ingredient_response.dart';
import '../../paging_result.dart';
import '../../request/ingredient_paging_request.dart';

abstract class IIngredientRepository {
  Future<PagingResult<IngredientResponse>?> getIngredients(IngredientPagingRequest request);
  // Future<PagingResult<IngredientResponse>?> getIngredientsByCategoryId(
  //     int categoryId, int pageIndex);
}
