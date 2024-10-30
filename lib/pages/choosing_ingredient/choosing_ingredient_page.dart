import 'package:flutter/material.dart';

class ChoosingIngredientPage extends StatefulWidget {
  const ChoosingIngredientPage({super.key});

  @override
  State<ChoosingIngredientPage> createState() => _ChoosingIngredientPageState();
}

class _ChoosingIngredientPageState extends State<ChoosingIngredientPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [Text("Category")],
        ),
      ),
    );
  }
}
