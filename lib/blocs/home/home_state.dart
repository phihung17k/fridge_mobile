import 'package:equatable/equatable.dart';

import '../../models/ingredient_model.dart';

class HomeState extends Equatable {
  /// List of ingredient to select as a part of recipe
  final List<IngredientModel>? ingredients;

  /// Assume [options] includes all ingredients.
  /// Use to display in OverlayPortal when input matches ingredient's name.
  final List<IngredientModel>? options;

  final List<IngredientModel>? selectedOptions;
  final List<IngredientModel>? remainingOptions;

  const HomeState({this.ingredients, this.options, this.selectedOptions, this.remainingOptions});

  HomeState copyWith(
      {List<IngredientModel>? ingredients,
      List<IngredientModel>? options,
      List<IngredientModel>? selectedOptions,
      List<IngredientModel>? remainingOptions}) {
    return HomeState(
      ingredients: ingredients ?? this.ingredients,
      options: options ?? this.options,
      selectedOptions: selectedOptions ?? this.selectedOptions,
      remainingOptions: remainingOptions ?? this.remainingOptions,
    );
  }

  @override
  List<Object?> get props => [ingredients, options, selectedOptions, remainingOptions];
}
