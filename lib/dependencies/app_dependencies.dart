import 'package:fridge_mobile/dependencies/bloc_dependencies.dart';
import 'package:get_it/get_it.dart';
import 'page_dependencies.dart';

class AppDependencies {
  static GetIt get _injector => GetIt.instance;

  static void setup() {
    BlocDependencies.setup(_injector);
    PageDependencies.setup(_injector);
  }
}
