import 'package:flutter/material.dart';

class RecipeIngredients extends StatelessWidget {
  const RecipeIngredients({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height / 6,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 6,
        itemBuilder: (context, index) {
          EdgeInsetsGeometry? margin;
          if (index == 0) {
            margin = const EdgeInsets.fromLTRB(10, 4, 4, 4);
          } else if (index == 5) {
            margin = const EdgeInsets.fromLTRB(4, 4, 10, 4);
          }
          return Card(
            elevation: 3,
            margin: margin,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: const AssetImage("assets/images/tomato.png"),
                  height: MediaQuery.sizeOf(context).height / 10,
                ),
                const Text("Tomato")
              ],
            ),
          );
        },
      ),
    );
  }
}
