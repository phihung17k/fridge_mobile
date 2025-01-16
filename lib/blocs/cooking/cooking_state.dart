import 'package:equatable/equatable.dart';
import 'package:fridge_mobile/data/models/selected_ingredient_model.dart';

class CookingState extends Equatable {
  final List<SelectableIngredientModel>? ingredients;
  final bool? hasNext;
  final int? pageIndex;
  final bool? isLoadMore;

  const CookingState({
    this.ingredients,
    this.hasNext,
    this.pageIndex,
    this.isLoadMore,
  });

  CookingState copyWith({
    List<SelectableIngredientModel>? ingredients,
    bool? hasNext,
    int? pageIndex,
    bool? isLoadMore,
  }) {
    return CookingState(
      ingredients: ingredients ?? this.ingredients,
      hasNext: hasNext ?? this.hasNext,
      pageIndex: pageIndex ?? this.pageIndex,
      isLoadMore: isLoadMore ?? this.isLoadMore,
    );
  }

  @override
  List<Object?> get props => [ingredients, hasNext, pageIndex, isLoadMore];
}
