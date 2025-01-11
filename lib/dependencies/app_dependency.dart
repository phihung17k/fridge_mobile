import 'dart:developer';

import 'package:fridge_mobile/data/clients/app_client.dart';
import 'package:fridge_mobile/dependencies/bloc_dependency.dart';
import 'package:fridge_mobile/dependencies/repository_dependency.dart';
import 'package:get_it/get_it.dart';
import 'page_dependency.dart';
import 'service_dependency.dart';

class AppDependencies {
  static GetIt get _injector => GetIt.instance;

  static void setup() {
    _injector.registerFactory(() => AppClient());

    RepositoryDependency.setup(_injector);
    ServiceDependency.setup(_injector);
    BlocDependencies.setup(_injector);
    PageDependencies.setup(_injector);
  }
}
