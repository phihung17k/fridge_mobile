import 'package:fridge_mobile/data/models/selectable_ingredient_model.dart';

class Dump {
  static List<SelectableIngredientModel> dumpIngredients = const [
    SelectableIngredientModel(id: '0', name: "Broccoli", imageUrl: "assets/images/broccoli.png"),
    SelectableIngredientModel(id: '1', name: "Chicken", imageUrl: "assets/images/chicken_meat.png"),
    SelectableIngredientModel(id: '2', name: "Pork", imageUrl: "assets/images/lean_pork.png"),
    SelectableIngredientModel(id: '3', name: "Tomato", imageUrl: "assets/images/tomato.png"),
    SelectableIngredientModel(id: '4', name: "Fish", imageUrl: "assets/images/fish.png"),
  ];
}
