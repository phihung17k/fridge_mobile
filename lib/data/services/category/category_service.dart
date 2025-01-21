import 'package:fridge_mobile/data/models/category_model.dart';
import 'package:fridge_mobile/data/repositories/category/i_category_repository.dart';
import 'package:fridge_mobile/data/response/category_response.dart';
import 'package:fridge_mobile/data/services/category/i_category_service.dart';

class CategoryService implements ICategoryService {
  final ICategoryRepository repository;

  CategoryService(this.repository);

  @override
  Future<List<CategoryModel>?> getAllCategory() async {
    List<CategoryResponse>? response = await repository.getAllCategory();

    return response
        ?.map((e) => CategoryModel(
              id: e.id,
              name: e.name,
              localName: e.localName,
              description: e.description,
            ))
        .toList();
  }
}
