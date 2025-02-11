import 'package:equatable/equatable.dart';

import 'selectable_ingredient_model.dart';

class SelectableIngredientModelWrapper extends Equatable {
  // final int? categoryId;
  final List<SelectableIngredientModel>? ingredients;
  final bool? hasNext;
  final int? pageIndex;
  final double? scrollPosition;

  const SelectableIngredientModelWrapper({
    // this.categoryId,
    this.ingredients,
    this.hasNext,
    this.pageIndex,
    this.scrollPosition,
  });

  SelectableIngredientModelWrapper copyWith({
    // int? categoryId,
    List<SelectableIngredientModel>? ingredients,
    bool? hasNext,
    int? pageIndex,
    double? scrollPosition,
  }) {
    return SelectableIngredientModelWrapper(
      // categoryId: categoryId ?? this.categoryId,
      ingredients: ingredients ?? this.ingredients,
      hasNext: hasNext ?? this.hasNext,
      pageIndex: pageIndex ?? this.pageIndex,
      scrollPosition: scrollPosition ?? this.scrollPosition,
    );
  }

  @override
  List<Object?> get props => [
        ingredients,
        hasNext,
        pageIndex,
        scrollPosition,
      ];
}
