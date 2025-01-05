import 'package:fridge_mobile/data/models/ingredient_model.dart';

class SelectedIngredientModel extends IngredientModel {
  final bool isSelected;

  const SelectedIngredientModel({
    super.id,
    super.name,
    super.localName,
    super.description,
    super.imageUrl,
    this.isSelected = false,
  });

  @override
  @override
  SelectedIngredientModel copyWith({
    int? id,
    String? name,
    String? localName,
    String? description,
    String? imageUrl,
    bool? isSelected,
  }) {
    return SelectedIngredientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      localName: localName ?? this.localName,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
