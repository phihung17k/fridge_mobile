import 'package:fridge_mobile/data/models/selected_ingredient_model.dart';

class Dump {
  static List<SelectedIngredientModel> dumpIngredients = const [
    SelectedIngredientModel(id: '0', name: "Broccoli", imageUrl: "assets/images/broccoli.png"),
    SelectedIngredientModel(id: '1', name: "Chicken", imageUrl: "assets/images/chicken_meat.png"),
    SelectedIngredientModel(id: '2', name: "Pork", imageUrl: "assets/images/lean_pork.png"),
    SelectedIngredientModel(id: '3', name: "Tomato", imageUrl: "assets/images/tomato.png"),
    SelectedIngredientModel(id: '4', name: "Fish", imageUrl: "assets/images/fish.png"),
  ];
}
