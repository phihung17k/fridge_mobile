import 'package:equatable/equatable.dart';

import '../../data/models/ingredient_model.dart';

class CookingState extends Equatable {
  final List<IngredientModel>? ingredients;
  final bool? hasNext;
  final int? pageIndex;

  const CookingState({
    this.ingredients,
    this.hasNext,
    this.pageIndex,
  });

  CookingState copyWith({
    List<IngredientModel>? ingredients,
    bool? hasNext,
    int? pageIndex,
  }) {
    return CookingState(
      ingredients: ingredients ?? this.ingredients,
      hasNext: hasNext ?? this.hasNext,
      pageIndex: pageIndex ?? this.pageIndex,
    );
  }

  @override
  List<Object?> get props => [ingredients, hasNext, pageIndex];
}
