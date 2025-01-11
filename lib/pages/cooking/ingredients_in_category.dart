import 'package:flutter/material.dart';

import '../../data/models/ingredient_model.dart';

class IngredientsInCategory extends StatelessWidget {
  final List<IngredientModel> ingredients;

  const IngredientsInCategory({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        mainAxisExtent: 160,
      ),
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      itemCount: ingredients.length,
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, index) {
        IngredientModel ingredient = ingredients[index];
        // const IngredientModel(
        //     id: 1, imageUrl: "assets/images/broccoli.png", isSelected: true, name: "Test");
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
                      image: AssetImage(ingredient.imageUrl ?? "assets/images/broccoli.png"),
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
  }
}
