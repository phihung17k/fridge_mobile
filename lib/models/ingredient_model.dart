import 'package:equatable/equatable.dart';

class IngredientModel extends Equatable {
  final int? id;
  final String? name;
  final String? imageUrl;

  const IngredientModel({
    this.id,
    this.name,
    this.imageUrl,
  });

  IngredientModel copyWith({
    int? id,
    String? name,
    String? imageUrl,
    bool? isSelected,
  }) {
    return IngredientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props => [id];
}
