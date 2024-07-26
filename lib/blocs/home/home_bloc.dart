import 'package:fridge_mobile/blocs/base_bloc.dart';
import 'package:fridge_mobile/blocs/home/home_state.dart';
import 'package:fridge_mobile/models/ingredient_model.dart';

class HomeBloc extends BaseBloc<HomeState> {
  HomeBloc()
      : super(HomeState(ingredients: const [
          IngredientModel(
              id: 0, name: "Broccoli", imageUrl: "assets/images/broccoli.png"),
          IngredientModel(
              id: 1,
              name: "Chicken",
              imageUrl: "assets/images/chicken_meat.png"),
          IngredientModel(
              id: 2, name: "Pork", imageUrl: "assets/images/lean_pork.png"),
          IngredientModel(
              id: 3, name: "Tomato", imageUrl: "assets/images/tomato.png"),
          IngredientModel(
              id: 4, name: "Fish", imageUrl: "assets/images/fish.png"),
        ]));

  Stream<List<IngredientModel>> get ingredientListStream =>
      stateStream.map((state) => state.ingredients!).distinct();

  void loadIngredients() {
    emit(state);
  }

  void selectIngredient(int index) {
    List<IngredientModel> ingredients = state.ingredients!.toList();
    IngredientModel ingredient = state.ingredients![index];
    ingredients[index] =
        ingredient.copyWith(isSelected: !ingredient.isSelected);
    emit(state.copyWith(ingredients: ingredients));
  }
}
