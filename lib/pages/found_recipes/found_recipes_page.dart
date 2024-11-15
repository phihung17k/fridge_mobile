import 'package:flutter/material.dart';

class FoundRecipesPage extends StatefulWidget {
  const FoundRecipesPage({super.key});

  @override
  State<FoundRecipesPage> createState() => _FoundRecipesPageState();
}

class _FoundRecipesPageState extends State<FoundRecipesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Recipes"),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: const Image(
                image: AssetImage("assets/images/broccoli.png"),
              ),
            ),
          );
        },
      ),
    );
  }
}
