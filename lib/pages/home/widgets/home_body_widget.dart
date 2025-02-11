import 'package:flutter/material.dart';
import '../../../blocs/bloc_provider.dart';
import '../../../blocs/home/home_bloc.dart';
import '../../../data/models/selectable_ingredient_model.dart';

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    HomeBloc? bloc = BlocProvider.maybeOf<HomeBloc>(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ingredients",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          StreamBuilder<List<SelectableIngredientModel>>(
            stream: bloc?.ingredientListStream,
            builder: (context, snapshot) {
              List<SelectableIngredientModel>? ingredients = snapshot.data;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  mainAxisExtent: 120,
                ),
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                itemCount: ingredients?.length ?? 0,
                itemBuilder: (context, index) {
                  SelectableIngredientModel ingredient = ingredients![index];
                  return InkWell(
                    onTap: () => bloc?.selectIngredient(index),
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          width: ingredient.isSelected ? 5 : 0.1,
                          color: ingredient.isSelected ? Colors.blue : Colors.transparent,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Image(
                                image: AssetImage(ingredient.imageUrl!),
                              ),
                            ),
                            Text(ingredient.name!)
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
