import 'package:equatable/equatable.dart';
import 'package:fridge_mobile/data/models/selected_ingredient_model.dart';

import '../../data/models/category_model.dart';

class CookingState extends Equatable {
  // selectCategoryId = 0 => All

  final List<CategoryModel>? categories;
  final List<SelectableIngredientModel>? ingredients;
  final int? selectedCategoryId;
  final bool? hasNext;
  final int? pageIndex;
  final bool? isLoadMore;

  const CookingState({
    this.categories,
    this.ingredients,
    this.selectedCategoryId,
    this.hasNext,
    this.pageIndex,
    this.isLoadMore,
  });

  CookingState copyWith({
    List<CategoryModel>? categories,
    List<SelectableIngredientModel>? ingredients,
    int? selectedCategoryId,
    bool? hasNext,
    int? pageIndex,
    bool? isLoadMore,
  }) {
    return CookingState(
      categories: categories ?? this.categories,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      ingredients: ingredients ?? this.ingredients,
      hasNext: hasNext ?? this.hasNext,
      pageIndex: pageIndex ?? this.pageIndex,
      isLoadMore: isLoadMore ?? this.isLoadMore,
    );
  }

  @override
  List<Object?> get props => [
        categories,
        ingredients,
        selectedCategoryId,
        hasNext,
        pageIndex,
        isLoadMore,
      ];
}
