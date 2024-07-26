import 'package:fridge_mobile/blocs/home/home_bloc.dart';
import 'package:get_it/get_it.dart';

class BlocDependencies {
  static void setup(GetIt injector) {
    injector.registerFactory(() => HomeBloc());
  }
}
