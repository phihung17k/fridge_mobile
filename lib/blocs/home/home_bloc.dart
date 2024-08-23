import 'package:fridge_mobile/blocs/base_bloc.dart';
import 'package:fridge_mobile/blocs/home/home_state.dart';
import 'package:fridge_mobile/data/dump.dart';
import 'package:fridge_mobile/models/ingredient_model.dart';

class HomeBloc extends BaseBloc<HomeState> {
  HomeBloc()
      : super(const HomeState(
          ingredients: [],
          options: [],
          selectedOptions: [],
          remainingOptions: [],
        ));

  Stream<List<IngredientModel>> get ingredientListStream =>
      stateStream.map((state) => state.ingredients!).distinct();

  Stream<List<IngredientModel>> get optionsStream => stateStream.map((state) => state.options!);
  Stream<List<IngredientModel>> get selectedOptionsStream =>
      stateStream.map((state) => state.selectedOptions!);

  void loadIngredients() {
    emit(state.copyWith(
      ingredients: Dump.dumpIngredients,
      options: Dump.dumpIngredients,
      remainingOptions: Dump.dumpIngredients,
    ));
  }

  void selectIngredient(int index) {
    List<IngredientModel> ingredients = state.ingredients!.toList();
    IngredientModel ingredient = state.ingredients![index];
    ingredients[index] = ingredient.copyWith(isSelected: !ingredient.isSelected);
    emit(state.copyWith(ingredients: ingredients));
  }

  // void removeSelectedOption(IngredientModel option) {
  //   List<IngredientModel> options = state.options!.toList();
  //   options.remove(option);
  //   emit(state.copyWith(options: options));
  // }

  void filterOptions(String value) {
    List<IngredientModel> options = state.remainingOptions!.toList();
    List<IngredientModel> filteredOptions =
        options.where((item) => item.name!.toLowerCase().contains(value.toLowerCase())).toList();
    emit(state.copyWith(options: filteredOptions));
  }

  /// Tasks:
  /// - update list of selected options
  /// - remove the selected one in list of remaining options
  void selectOption(IngredientModel option) {
    List<IngredientModel> selectedOptions = state.selectedOptions!.toList();
    selectedOptions.add(option);

    List<IngredientModel> remainingOptions = state.remainingOptions!.toList();
    remainingOptions.remove(option);

    emit(state.copyWith(selectedOptions: selectedOptions, remainingOptions: remainingOptions));
  }

  /// Tasks:
  /// - update list of remaining options
  /// - remove the selected option in list of selected options
  void restoreOption(IngredientModel option) {
    List<IngredientModel> remainingOptions = state.remainingOptions!.toList();
    remainingOptions.add(option);

    List<IngredientModel> selectedOptions = state.selectedOptions!.toList();
    selectedOptions.remove(option);

    emit(state.copyWith(selectedOptions: selectedOptions, remainingOptions: remainingOptions));
  }
}
