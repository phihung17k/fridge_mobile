import 'package:fridge_mobile/data/models/category_model.dart';

abstract class ICategoryService {
  Future<List<CategoryModel>?> getAllCategory();
}
