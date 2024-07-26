import 'package:equatable/equatable.dart';

import '../../models/ingredient_model.dart';

class HomeState extends Equatable {
  final List<IngredientModel>? ingredients;

  const HomeState({this.ingredients});

  HomeState copyWith({List<IngredientModel>? ingredients}) {
    return HomeState(
      ingredients: ingredients ?? this.ingredients,
    );
  }

  @override
  List<Object?> get props => [ingredients];
}
