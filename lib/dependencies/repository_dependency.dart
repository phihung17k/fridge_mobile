import 'package:fridge_mobile/data/repositories/category/category_repository.dart';
import 'package:fridge_mobile/data/repositories/category/i_category_repository.dart';
import 'package:fridge_mobile/data/repositories/ingredient/i_ingredient_repository.dart';
import 'package:fridge_mobile/data/repositories/ingredient/ingredient_repository.dart';
import 'package:get_it/get_it.dart';

class RepositoryDependency {
  static void setup(GetIt injector) {
    injector.registerFactory<IIngredientRepository>(() => IngredientRepository(injector()));
    injector.registerFactory<ICategoryRepository>(() => CategoryRepository(injector()));
  }
}
