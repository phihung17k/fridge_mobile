import 'package:flutter/material.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        shape: const Border(bottom: BorderSide(color: Colors.grey)),
        title: const Text("Recipe"),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return DecoratedBox(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Theme.of(context).colorScheme.outlineVariant))),
            child: Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  leading: const Image(
                    image: AssetImage("assets/images/broccoli.png"),
                  ),
                  title: const Text("Recipe Name"),
                  subtitle: const Row(
                    children: [
                      Icon(Icons.access_time_rounded),
                      Text("20 min"),
                    ],
                  ),
                  trailing: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconButton(
                        onPressed: () {},
                        padding: const EdgeInsets.all(0),
                        alignment: Alignment.topCenter,
                        icon: const Icon(Icons.more_vert_outlined),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
