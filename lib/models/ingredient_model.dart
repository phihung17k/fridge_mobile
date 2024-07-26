import 'package:equatable/equatable.dart';

class IngredientModel extends Equatable {
  final int? id;
  final String? name;
  final String? imageUrl;
  final bool isSelected;

  const IngredientModel(
      {this.id, this.name, this.imageUrl, this.isSelected = false});

  IngredientModel copyWith(
      {int? id, String? name, String? imageUrl, bool? isSelected}) {
    return IngredientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [id];
}
