import 'package:fridge_mobile/data/response/ingredient_response.dart';

import '../../paging_result.dart';

abstract class IIngredientRepository {
  Future<PagingResult<IngredientResponse>?> getIngredients(int pageIndex);
}
