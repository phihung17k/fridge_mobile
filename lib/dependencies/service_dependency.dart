import 'package:fridge_mobile/data/services/ingredient/i_ingredient_service.dart';
import 'package:fridge_mobile/data/services/ingredient/ingredient_service.dart';
import 'package:get_it/get_it.dart';

class ServiceDependency {
  static void setup(GetIt injector) {
    injector.registerFactory<IIngredientService>(() => IngredientService(injector()));
  }
}
