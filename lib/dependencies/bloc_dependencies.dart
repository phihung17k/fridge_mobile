import 'package:get_it/get_it.dart';
import '../blocs/blocs.dart';

class BlocDependencies {
  static void setup(GetIt injector) {
    injector.registerFactory(() => MainBloc());
    injector.registerFactory(() => HomeBloc());
    injector.registerFactory(() => RecipeFormBloc());
  }
}
