import 'package:equatable/equatable.dart';

class IngredientModel extends Equatable {
  final int? id;
  final String? name;
  final String? localName;
  final String? description;
  final String? imageUrl;

  const IngredientModel({
    this.id,
    this.name,
    this.localName,
    this.description,
    this.imageUrl,
  });

  IngredientModel copyWith({
    int? id,
    String? name,
    String? localName,
    String? description,
    String? imageUrl,
  }) {
    return IngredientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      localName: localName ?? this.localName,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props => [id];
}
