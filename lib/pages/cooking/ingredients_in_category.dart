import 'dart:async';
import 'dart:developer';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import '../../blocs/bloc_provider.dart';
import '../../blocs/cooking/cooking_bloc.dart';
import '../../data/models/selectable_ingredient_model.dart';

class IngredientsInCategory extends StatefulWidget {
  static final EventBus eventBus = EventBus();
  const IngredientsInCategory({super.key});

  @override
  State<IngredientsInCategory> createState() => _IngredientsInCategoryState();
}

class _IngredientsInCategoryState extends State<IngredientsInCategory> {
  late final ScrollController scrollController;
  late CookingBloc? bloc;
  StreamSubscription? eventBusSubscription;
  Timer? debounceTime;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();

    scrollController.addListener(
      () {
        debounceTime?.cancel();
        debounceTime = Timer(const Duration(milliseconds: 300), () {
          if (scrollController.hasClients) {
            bloc?.updateScrollPosition(scrollController.offset);
          }
        });

        if (scrollController.position.pixels >= scrollController.position.maxScrollExtent) {
          bloc?.loadMoreIngredients();
        }
      },
    );

    eventBusSubscription = IngredientsInCategory.eventBus.on().listen((data) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          if (scrollController.hasClients) {
            scrollController.jumpTo(data);
          }
        },
      );
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = BlocProvider.maybeOf<CookingBloc>(context)!;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<(List<SelectableIngredientModel>, bool, bool)>(
      stream: bloc?.ingredients_waitGettingIngredients_loadmoreStream,
      builder: (context, snapshot) {
        // log("StreamBuilder<(List<IngredientModel>, bool)> ${snapshot.data}");
        if (!snapshot.hasData || snapshot.data!.$2) {
          return const Center(child: CircularProgressIndicator());
        }
        List<SelectableIngredientModel> ingredients = snapshot.data!.$1;
        if (ingredients.isEmpty) {
          return const Center(child: Text("No items available."));
        }
        // log("LENGTH ${ingredients.length}");
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
              if (snapshot.hasData && snapshot.data?.$3 == true)
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
    eventBusSubscription?.cancel();
    super.dispose();
  }
}
