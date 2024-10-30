import 'package:flutter/material.dart';
import 'package:fridge_mobile/pages/choosing_ingredient/choosing_ingredient_page.dart';
import 'package:fridge_mobile/pages/home/home_page.dart';
import 'package:get_it/get_it.dart';

import '../routes.dart';

class PageDependencies {
  static void setup(GetIt injector) {
    // injector.registerFactory<Widget>(() => const HomePage(),
    //     instanceName: Routes.home);
    injector.registerFactory<Widget>(() => const HomePage(), instanceName: Routes.home);
    injector.registerFactory<Widget>(() => const ChoosingIngredientPage(),
        instanceName: Routes.choosingIngredient);
  }
}
