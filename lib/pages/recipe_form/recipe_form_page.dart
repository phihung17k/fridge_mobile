import 'package:flutter/material.dart';

class RecipeFormPage extends StatefulWidget {
  const RecipeFormPage({super.key});

  @override
  State<RecipeFormPage> createState() => _RecipeFormPageState();
}

class _RecipeFormPageState extends State<RecipeFormPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text("Selected Ingredient"),
          forceMaterialTransparency: true,
          scrolledUnderElevation: 2,
          surfaceTintColor: Colors.amber,
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            onTap: (value) {},
            tabs: const <Widget>[
              Tab(text: "Overview"),
              Tab(text: "Ingredients"),
              Tab(text: "Steps"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: "Name"),
                    validator: (value) {},
                  )
                ],
              ),
            ),
            Text("2"),
            Text("3"),
          ],
        ),
      ),
    );
  }
}
