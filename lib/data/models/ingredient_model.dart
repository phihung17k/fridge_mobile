import 'package:equatable/equatable.dart';
import 'package:fridge_mobile/data/models/category_model.dart';

class IngredientModel extends Equatable {
  final String? id;
  final String? name;
  final String? localName;
  final String? description;
  final String? imageUrl;
  final CategoryModel? category;

  const IngredientModel({
    this.id,
    this.name,
    this.localName,
    this.description,
    this.imageUrl,
    this.category,
  });

  IngredientModel copyWith({
    String? id,
    String? name,
    String? localName,
    String? description,
    String? imageUrl,
    CategoryModel? category,
  }) {
    return IngredientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      localName: localName ?? this.localName,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
    );
  }

  @override
  List<Object?> get props => [id];
}
