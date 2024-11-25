import 'package:flutter/material.dart';
import 'package:fridge_mobile/pages/recipe_detail/widgets/recipe_directions.dart';
import 'package:fridge_mobile/pages/recipe_detail/widgets/recipe_ingredients.dart';
import 'package:fridge_mobile/pages/recipe_detail/widgets/recipe_overview.dart';

class RecipeDetailPage extends StatefulWidget {
  const RecipeDetailPage({super.key});

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Food name"),
        forceMaterialTransparency: true,
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RecipeOverview(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Ingredients"),
                  Text("7 items"),
                ],
              ),
            ),
            RecipeIngredients(),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 8),
              child: Row(
                children: [
                  Text("Directions"),
                ],
              ),
            ),
            RecipeDirections(),
            RecipeDirections(),
            RecipeDirections(),
            RecipeDirections(),
          ],
        ),
      ),
    );
  }
}
