import 'package:equatable/equatable.dart';
import 'package:fridge_mobile/data/models/selected_ingredient_model.dart';

import '../../data/models/category_model.dart';

class CookingState extends Equatable {
  // selectCategoryId = 0 => All

  final List<SelectableIngredientModel>? ingredients;
  final bool? hasNext;
  final int? pageIndex;
  final bool? isLoadMore;
  final List<CategoryModel>? categories;
  final int? selectedCategoryId;

  const CookingState({
    this.ingredients,
    this.hasNext,
    this.pageIndex,
    this.isLoadMore,
    this.categories,
    this.selectedCategoryId,
  });

  CookingState copyWith({
    List<SelectableIngredientModel>? ingredients,
    bool? hasNext,
    int? pageIndex,
    bool? isLoadMore,
    List<CategoryModel>? categories,
    int? selectedCategoryId,
  }) {
    return CookingState(
      ingredients: ingredients ?? this.ingredients,
      hasNext: hasNext ?? this.hasNext,
      pageIndex: pageIndex ?? this.pageIndex,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      categories: categories ?? this.categories,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
    );
  }

  @override
  List<Object?> get props => [
        ingredients,
        hasNext,
        pageIndex,
        isLoadMore,
        categories,
        selectedCategoryId,
      ];
}
