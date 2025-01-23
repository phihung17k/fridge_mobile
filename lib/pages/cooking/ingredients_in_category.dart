import 'dart:developer';
import 'package:flutter/material.dart';
import '../../blocs/bloc_provider.dart';
import '../../blocs/cooking/cooking_bloc.dart';
import '../../data/models/selected_ingredient_model.dart';

class IngredientsInCategory extends StatefulWidget {
  const IngredientsInCategory({super.key});

  @override
  State<IngredientsInCategory> createState() => _IngredientsInCategoryState();
}

class _IngredientsInCategoryState extends State<IngredientsInCategory> {
  late final ScrollController scrollController;
  late CookingBloc? bloc;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();

    scrollController.addListener(
      () {
        if (scrollController.position.pixels >= scrollController.position.maxScrollExtent) {
          // bloc!.state.selectedCategoryId == null
          //     ? bloc?.getIngredients()
          //     : bloc?.loadMoreIngredientsByCategoryId();
          bloc?.loadMoreIngredients();
        }
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = BlocProvider.maybeOf<CookingBloc>(context)!;
    // bloc?.getIngredients(pageIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<(List<SelectableIngredientModel>, bool)>(
      stream: bloc?.ingredientsAndLoadmoreStream,
      builder: (context, snapshot) {
        // log("StreamBuilder<(List<IngredientModel>, bool)> ${snapshot.data}");
        if (!snapshot.hasData || snapshot.data!.$1.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        List<SelectableIngredientModel> ingredients = snapshot.data!.$1;
        return SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              GridView.builder(
                // controller: scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  mainAxisExtent: 160,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: ingredients.length,
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  SelectableIngredientModel ingredient = ingredients[index];
                  return GestureDetector(
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
                                image:
                                    AssetImage(ingredient.imageUrl ?? "assets/images/broccoli.png"),
                              ),
                            ),
                            Text(
                              ingredient.name!,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              if (snapshot.hasData && snapshot.data?.$2 == true)
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(child: CircularProgressIndicator()),
                )
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
