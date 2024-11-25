import 'package:flutter/material.dart';

import '../../../utils/string_constant.dart';

class RecipeDirections extends StatelessWidget {
  const RecipeDirections({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                constraints: const BoxConstraints(
                  minHeight: 30,
                  minWidth: 30,
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Theme.of(context).primaryColorLight),
                child: const Center(child: Text("1")),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      StringConstant.recipeDetailSample,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Image(
                            image: const AssetImage("assets/images/tomato.png"),
                            height: MediaQuery.sizeOf(context).height / 10,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Image(
                            image: const AssetImage("assets/images/tomato.png"),
                            height: MediaQuery.sizeOf(context).height / 10,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
