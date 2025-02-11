import 'package:fridge_mobile/data/models/category_model.dart';
import 'package:fridge_mobile/data/models/ingredient_model.dart';

class SelectableIngredientModel extends IngredientModel {
  final bool isSelected;

  const SelectableIngredientModel({
    super.id,
    super.name,
    super.localName,
    super.description,
    super.imageUrl,
    super.category,
    this.isSelected = false,
  });

  @override
  SelectableIngredientModel copyWith({
    String? id,
    String? name,
    String? localName,
    String? description,
    String? imageUrl,
    CategoryModel? category,
    bool? isSelected,
  }) {
    return SelectableIngredientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      localName: localName ?? this.localName,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
