import 'package:flutter/material.dart';
import 'package:fridge_mobile/routes.dart';

class SelectedIngredientPage extends StatefulWidget {
  const SelectedIngredientPage({super.key});

  @override
  State<SelectedIngredientPage> createState() => _SelectedIngredientPageState();
}

class _SelectedIngredientPageState extends State<SelectedIngredientPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Selected Ingredient"),
        forceMaterialTransparency: true,
        scrolledUnderElevation: 2,
        surfaceTintColor: Colors.amber,
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                leading: const Image(
                  image: AssetImage("assets/images/broccoli.png"),
                ),
                title: const Text("Title"),
                trailing: IconButton.filledTonal(
                  onPressed: () {},
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: const Size(35, 35),
                    iconSize: 20,
                  ),
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
              const Divider(
                indent: 15,
                endIndent: 15,
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FilledButton(
              onPressed: () => Navigator.pushNamed(context, Routes.foundRecipes),
              child: const Text("Find recipes"),
            )
          ],
        ),
      ),
    );
  }
}
