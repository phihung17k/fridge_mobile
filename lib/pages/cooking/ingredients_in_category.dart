import 'dart:developer';

import 'package:flutter/material.dart';
import '../../blocs/bloc_provider.dart';
import '../../blocs/cooking/cooking_bloc.dart';
import '../../data/models/ingredient_model.dart';

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
        if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
          bloc?.getIngredients();
        }
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = BlocProvider.maybeOf<CookingBloc>(context)!;
    bloc?.getIngredients(pageIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<IngredientModel>>(
        stream: bloc?.ingredientListStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          List<IngredientModel> ingredients = snapshot.data!;
          return Column(
            children: [
              Expanded(
                child: Scrollbar(
                  controller: scrollController,
                  thumbVisibility: true,
                  child: GridView.builder(
                    controller: scrollController,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      mainAxisExtent: 160,
                    ),
                    shrinkWrap: true,
                    // physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    itemCount: ingredients.length,
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      IngredientModel ingredient = ingredients[index];
                      return InkWell(
                        // onTap: () => bloc?.selectIngredient(index),
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(
                              // width: ingredient.isSelected ? 5 : 0.1,
                              // color: ingredient.isSelected ? Colors.blue : Colors.transparent,
                              width: 0.1,
                              color: Colors.transparent,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Image(
                                    image: AssetImage(
                                        ingredient.imageUrl ?? "assets/images/broccoli.png"),
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
                ),
              ),
              StreamBuilder<bool>(
                  stream: bloc?.isLoadMoreStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data == true) {
                      debugPrint("LOAD MORE");
                      return const Center(child: CircularProgressIndicator());
                    }
                    debugPrint("NO LOAD MORE");
                    return const SizedBox(
                      height: 10,
                    );
                    // return AnimatedSwitcher(
                    //   duration: Duration(milliseconds: 500),
                    //   child: snapshot.hasData && snapshot.data == true
                    //       ? Center(child: CircularProgressIndicator())
                    //       : SizedBox.shrink(), // Hides when not loading
                    // );
                  }),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
