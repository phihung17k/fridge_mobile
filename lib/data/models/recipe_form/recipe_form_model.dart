import 'package:equatable/equatable.dart';
import 'package:fridge_mobile/data/models/selectable_ingredient_model.dart';
import 'package:fridge_mobile/data/models/recipe_form/step_model.dart';

class RecipeFormModel extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final String? duration;
  final int? serving;
  final List<SelectableIngredientModel>? ingredients;
  final List<StepModel>? steps;

  const RecipeFormModel({
    this.id,
    this.name,
    this.description,
    this.duration,
    this.serving,
    this.ingredients,
    this.steps,
  });

  RecipeFormModel copyWith({
    int? id,
    String? name,
    String? description,
    String? duration,
    int? serving,
    List<SelectableIngredientModel>? ingredients,
    List<StepModel>? steps,
  }) {
    return RecipeFormModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      serving: serving ?? this.serving,
      steps: steps ?? this.steps,
    );
  }

  @override
  List<Object?> get props => [id];
}
