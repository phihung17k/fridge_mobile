import 'package:equatable/equatable.dart';
import 'package:fridge_mobile/data/models/selected_ingredient_model.dart';

import '../../data/models/category_model.dart';

class CookingState extends Equatable {
  final List<SelectableIngredientModel>? ingredients;
  final bool? hasNext;
  final int? pageIndex;
  final bool? isLoadMore;
  final List<CategoryModel>? categories;

  const CookingState({
    this.ingredients,
    this.hasNext,
    this.pageIndex,
    this.isLoadMore,
    this.categories,
  });

  CookingState copyWith({
    List<SelectableIngredientModel>? ingredients,
    bool? hasNext,
    int? pageIndex,
    bool? isLoadMore,
    List<CategoryModel>? categories,
  }) {
    return CookingState(
      ingredients: ingredients ?? this.ingredients,
      hasNext: hasNext ?? this.hasNext,
      pageIndex: pageIndex ?? this.pageIndex,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => [ingredients, hasNext, pageIndex, isLoadMore, categories];
}
