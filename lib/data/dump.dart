import 'package:fridge_mobile/models/ingredient_model.dart';

class Dump {
  static List<IngredientModel> dumpIngredients = const [
    IngredientModel(
        id: 0, name: "Broccoli", imageUrl: "assets/images/broccoli.png"),
    IngredientModel(
        id: 1, name: "Chicken", imageUrl: "assets/images/chicken_meat.png"),
    IngredientModel(
        id: 2, name: "Pork", imageUrl: "assets/images/lean_pork.png"),
    IngredientModel(
        id: 3, name: "Tomato", imageUrl: "assets/images/tomato.png"),
    IngredientModel(id: 4, name: "Fish", imageUrl: "assets/images/fish.png"),
  ];
}
