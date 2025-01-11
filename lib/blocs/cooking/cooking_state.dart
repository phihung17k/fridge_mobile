import 'package:equatable/equatable.dart';

import '../../data/models/ingredient_model.dart';

class CookingState extends Equatable {
  final List<IngredientModel>? ingredients;

  const CookingState({this.ingredients});

  CookingState copyWith({
    List<IngredientModel>? ingredients,
  }) {
    return CookingState(
      ingredients: ingredients ?? this.ingredients,
    );
  }

  @override
  List<Object?> get props => [ingredients];
}
