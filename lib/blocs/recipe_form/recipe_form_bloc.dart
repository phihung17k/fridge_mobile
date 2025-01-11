import 'package:fridge_mobile/blocs/base_bloc.dart';
import 'package:fridge_mobile/blocs/recipe_form/recipe_form_state.dart';
import 'package:fridge_mobile/data/services/ingredient/ingredient_service.dart';

class RecipeFormBloc extends BaseBloc<RecipeFormState> {
  // final IngredientService _ingredientService;

  RecipeFormBloc() : super(const RecipeFormState(
            // hour: 0,
            // minute: 0,
            ));

  String combineTime(int hour, int minute) {
    String result = "";
    result = hour < 10 ? "0$hour" : "$hour";
    result = minute < 10 ? "$result : 0$minute" : "$result : $minute";
    return result;
  }

  String initTime() {
    return combineTime(state.hour, state.minute);
  }

  void updateTimeFromDialog(int hour, int minute) {
    emit(state.copyWith(
      hour: hour,
      minute: minute,
    ));
  }
}
