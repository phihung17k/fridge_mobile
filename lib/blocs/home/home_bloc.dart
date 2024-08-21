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

  void removeSelectedOption(IngredientModel option) {
    List<IngredientModel> options = state.remainingOptions!.toList();
    options.remove(option);
    emit(state.copyWith(remainingOptions: options));
  }

  void restoreOption(List<IngredientModel> addedOptions) {
    List<IngredientModel> options = state.remainingOptions!.toList();
    options.addAll(addedOptions);
    emit(state.copyWith(remainingOptions: options));
  }
}
