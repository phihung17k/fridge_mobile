import 'package:equatable/equatable.dart';
import 'package:fridge_mobile/data/models/selectable_ingredient_model.dart';
import 'package:fridge_mobile/data/models/selectable_ingredient_model_wrapper.dart';

import '../../data/models/category_model.dart';

class CookingState extends Equatable {
  // selectCategoryId = 0 => All

  final List<CategoryModel>? categories;
  final Map<int, SelectableIngredientModelWrapper?>? categoryIngredientsMap;
  final List<SelectableIngredientModel>? ingredients;
  final int? selectedCategoryId;
  final bool? isLoadMore;
  final bool? waitGettingIngredients;
  final double? scrollPosition;

  const CookingState({
    this.categories,
    this.categoryIngredientsMap,
    this.ingredients,
    this.selectedCategoryId,
    this.isLoadMore,
    this.waitGettingIngredients,
    this.scrollPosition,
  });

  CookingState.empty()
      : categories = [],
        categoryIngredientsMap = {},
        ingredients = [],
        selectedCategoryId = 0, // All
        isLoadMore = false,
        waitGettingIngredients = false,
        scrollPosition = 0;

  CookingState copyWith({
    List<CategoryModel>? categories,
    Map<int, SelectableIngredientModelWrapper?>? categoryIngredientsMap,
    List<SelectableIngredientModel>? ingredients,
    int? selectedCategoryId,
    bool? isLoadMore,
    bool? waitGettingIngredients,
    double? scrollPosition,
  }) {
    return CookingState(
      categories: categories ?? this.categories,
      categoryIngredientsMap: categoryIngredientsMap ?? this.categoryIngredientsMap,
      ingredients: ingredients ?? this.ingredients,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      waitGettingIngredients: waitGettingIngredients ?? this.waitGettingIngredients,
      scrollPosition: scrollPosition ?? this.scrollPosition,
    );
  }

  @override
  List<Object?> get props => [
        categories,
        ingredients,
        categoryIngredientsMap,
        selectedCategoryId,
        isLoadMore,
        waitGettingIngredients,
        scrollPosition,
      ];
}
