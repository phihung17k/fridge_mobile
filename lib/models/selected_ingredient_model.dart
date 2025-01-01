import 'package:fridge_mobile/models/ingredient_model.dart';

class SelectedIngredientModel extends IngredientModel {
  final bool isSelected;

  const SelectedIngredientModel({
    super.id,
    super.name,
    super.imageUrl,
    this.isSelected = false,
  });

  @override
  SelectedIngredientModel copyWith({
    int? id,
    String? name,
    String? imageUrl,
    bool? isSelected,
  }) {
    return SelectedIngredientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
