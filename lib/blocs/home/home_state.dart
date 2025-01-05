import 'package:equatable/equatable.dart';

import '../../data/models/selected_ingredient_model.dart';

class HomeState extends Equatable {
  /// List of ingredient to select as a part of recipe
  final List<SelectedIngredientModel>? ingredients;

  /// Assume [options] includes all ingredients.
  /// Use to display in OverlayPortal when input matches ingredient's name.
  final List<SelectedIngredientModel>? options;

  final List<SelectedIngredientModel>? selectedOptions;
  final List<SelectedIngredientModel>? remainingOptions;

  const HomeState({this.ingredients, this.options, this.selectedOptions, this.remainingOptions});

  HomeState copyWith(
      {List<SelectedIngredientModel>? ingredients,
      List<SelectedIngredientModel>? options,
      List<SelectedIngredientModel>? selectedOptions,
      List<SelectedIngredientModel>? remainingOptions}) {
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
