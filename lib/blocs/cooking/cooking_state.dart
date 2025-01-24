import 'package:equatable/equatable.dart';
import 'package:fridge_mobile/data/models/selected_ingredient_model.dart';

import '../../data/models/category_model.dart';

class CookingState extends Equatable {
  // selectCategoryId = 0 => All

  final List<CategoryModel>? categories;
  final Map<int, List<SelectableIngredientModel>?>? categoryIngredientsMap;
  final List<SelectableIngredientModel>? ingredients;
  final int? selectedCategoryId;
  final bool? hasNext;
  final int? pageIndex;
  final bool? isLoadMore;
  final bool? disableOtherButton;

  const CookingState({
    this.categories,
    this.categoryIngredientsMap,
    this.ingredients,
    this.selectedCategoryId,
    this.hasNext,
    this.pageIndex,
    this.isLoadMore,
    this.disableOtherButton,
  });

  CookingState copyWith({
    List<CategoryModel>? categories,
    Map<int, List<SelectableIngredientModel>?>? categoryIngredientsMap,
    List<SelectableIngredientModel>? ingredients,
    int? selectedCategoryId,
    bool? hasNext,
    int? pageIndex,
    bool? isLoadMore,
    bool? disableOtherButton,
  }) {
    return CookingState(
      categories: categories ?? this.categories,
      categoryIngredientsMap: categoryIngredientsMap ?? this.categoryIngredientsMap,
      ingredients: ingredients ?? this.ingredients,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      hasNext: hasNext ?? this.hasNext,
      pageIndex: pageIndex ?? this.pageIndex,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      disableOtherButton: disableOtherButton ?? this.disableOtherButton,
    );
  }

  @override
  List<Object?> get props => [
        categories,
        ingredients,
        categoryIngredientsMap,
        selectedCategoryId,
        hasNext,
        pageIndex,
        isLoadMore,
        disableOtherButton,
      ];
}
