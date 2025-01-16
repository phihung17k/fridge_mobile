import 'package:flutter/material.dart';
import 'package:fridge_mobile/pages/home/widgets/option_chip.dart';
import '../../../blocs/bloc_provider.dart';
import '../../../blocs/home/home_bloc.dart';
import '../../../data/models/selected_ingredient_model.dart';

class SelectedOptionChips extends StatelessWidget {
  const SelectedOptionChips({super.key});

  @override
  Widget build(BuildContext context) {
    HomeBloc? bloc = BlocProvider.maybeOf<HomeBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: StreamBuilder<List<SelectableIngredientModel>>(
          stream: bloc?.selectedOptionsStream,
          builder: (context, snapshot) {
            List<SelectableIngredientModel> ingredients = snapshot.data ?? [];
            return Wrap(
              spacing: 10,
              runSpacing: 5,
              children: List.generate(
                ingredients.length,
                (index) {
                  return OptionChip(
                      key: ValueKey(ingredients[index].id), ingredient: ingredients[index]);
                },
              ),
            );
          }),
    );
  }
}
