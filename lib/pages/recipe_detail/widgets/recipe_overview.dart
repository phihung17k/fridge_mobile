import 'package:flutter/material.dart';

class RecipeOverview extends StatelessWidget {
  const RecipeOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Image(
            image: AssetImage("assets/images/tomato.png"),
            // width: height / 5,
          ),
          Text(
            "This is my kind of breakfast egg sandwich and it takes under 5 minutes to make",
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(children: [Icon(Icons.group), Text("4 persons")]),
              Row(children: [Icon(Icons.access_time_rounded), Text("20 min")]),
              Row(children: [Icon(Icons.local_fire_department_outlined), Text("150 kcal")]),
            ],
          ),
        ],
      ),
    );
  }
}
