import 'package:equatable/equatable.dart';

import '../../data/models/selectable_ingredient_model.dart';

class HomeState extends Equatable {
  /// List of ingredient to select as a part of recipe
  final List<SelectableIngredientModel>? ingredients;

  /// Assume [options] includes all ingredients.
  /// Use to display in OverlayPortal when input matches ingredient's name.
  final List<SelectableIngredientModel>? options;

  final List<SelectableIngredientModel>? selectedOptions;
  final List<SelectableIngredientModel>? remainingOptions;

  const HomeState({this.ingredients, this.options, this.selectedOptions, this.remainingOptions});

  HomeState copyWith(
      {List<SelectableIngredientModel>? ingredients,
      List<SelectableIngredientModel>? options,
      List<SelectableIngredientModel>? selectedOptions,
      List<SelectableIngredientModel>? remainingOptions}) {
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
