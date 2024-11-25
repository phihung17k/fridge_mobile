import 'package:flutter/material.dart';

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
        leading: BackButton(),
        title: Text("Food name"),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
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
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Ingredients"),
                  Text("7 items"),
                ],
              ),
            ),
            SizedBox(
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
            )
          ],
        ),
      ),
    );
  }
}
