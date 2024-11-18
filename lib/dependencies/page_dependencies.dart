import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../pages/pages.dart';
import '../routes.dart';

class PageDependencies {
  static void setup(GetIt injector) {
    injector.registerFactory<Widget>(() => const MainPage(), instanceName: Routes.main);
    injector.registerFactory<Widget>(() => const HomePage(), instanceName: Routes.home);
    injector.registerFactory<Widget>(() => const CookingPage(), instanceName: Routes.cooking);
    injector.registerFactory<Widget>(() => const SavedPage(), instanceName: Routes.saved);
    injector.registerFactory<Widget>(() => const RecipePage(), instanceName: Routes.recipe);
    injector.registerFactory<Widget>(() => const ProfilePage(), instanceName: Routes.profile);
    injector.registerFactory<Widget>(() => const SelectedIngredientPage(),
        instanceName: Routes.selectingIngredient);
    injector.registerFactory<Widget>(() => const FoundRecipesPage(),
        instanceName: Routes.foundRecipes);
    injector.registerFactory<Widget>(() => const RecipeDetailPage(),
        instanceName: Routes.recipeDetail);
  }
}
