import 'package:fridge_mobile/data/response/category_response.dart';

abstract class ICategoryRepository {
  Future<List<CategoryResponse>?> getAllCategory();
}
