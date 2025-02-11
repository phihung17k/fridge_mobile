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
  // final bool? hasNext;
  // final int? pageIndex;
  final bool? isLoadMore;
  final bool? waitGettingIngredients;

  const CookingState({
    this.categories,
    this.categoryIngredientsMap,
    this.ingredients,
    this.selectedCategoryId,
    // this.hasNext,
    // this.pageIndex,
    this.isLoadMore,
    this.waitGettingIngredients,
  });

  CookingState.empty()
      : categories = [],
        categoryIngredientsMap = {},
        ingredients = [],
        selectedCategoryId = 0, // All
        // hasNext = false,
        // pageIndex = 1,
        isLoadMore = false,
        waitGettingIngredients = false;

  CookingState copyWith({
    List<CategoryModel>? categories,
    Map<int, SelectableIngredientModelWrapper?>? categoryIngredientsMap,
    List<SelectableIngredientModel>? ingredients,
    int? selectedCategoryId,
    bool? hasNext,
    int? pageIndex,
    bool? isLoadMore,
    bool? waitGettingIngredients,
  }) {
    return CookingState(
      categories: categories ?? this.categories,
      categoryIngredientsMap: categoryIngredientsMap ?? this.categoryIngredientsMap,
      ingredients: ingredients ?? this.ingredients,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      // hasNext: hasNext ?? this.hasNext,
      // pageIndex: pageIndex ?? this.pageIndex,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      waitGettingIngredients: waitGettingIngredients ?? this.waitGettingIngredients,
    );
  }

  @override
  List<Object?> get props => [
        categories,
        ingredients,
        categoryIngredientsMap,
        selectedCategoryId,
        // hasNext,
        // pageIndex,
        isLoadMore,
        waitGettingIngredients,
      ];
}
