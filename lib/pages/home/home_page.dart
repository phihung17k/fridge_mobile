import 'package:flutter/material.dart';
import 'package:fridge_mobile/models/ingredient_model.dart';
import 'package:get_it/get_it.dart';

import '../../blocs/home/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = GetIt.I.get<HomeBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: const Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Good morning"),
                Text(
                  "ABC",
                  textScaler: TextScaler.linear(1.5),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        leadingWidth: 120,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Image(
              image: ExactAssetImage("assets/images/man.png", scale: 1.5),
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Autocomplete<String>(
              optionsBuilder: (textEditingValue) {
                return [];
              },
              initialValue: TextEditingValue.empty,
              fieldViewBuilder: (context, textEditingController, focusNode,
                  onFieldSubmitted) {
                return TextField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  onEditingComplete: onFieldSubmitted,
                  onTapOutside: (event) => focusNode.unfocus(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    suffixIcon: Icon(
                      Icons.tune_rounded,
                      color: Colors.grey,
                    ),
                    hintText: "Find ingredient",
                  ),
                );
              },
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20, right: 10, bottom: 0, left: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ingredients",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 10),
              StreamBuilder<List<IngredientModel>>(
                  stream: bloc.ingredientListStream,
                  builder: (context, snapshot) {
                    debugPrint("AAAAAAAAAAAAA");
                    List<IngredientModel>? ingredients = snapshot.data;
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        mainAxisExtent: 120,
                      ),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: ingredients?.length ?? 0,
                      itemBuilder: (context, index) {
                        IngredientModel ingredient = ingredients![index];
                        return InkWell(
                          onTap: () => bloc.selectIngredient(index),
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                width: ingredient.isSelected ? 5 : 0.1,
                                color: ingredient.isSelected
                                    ? Colors.blue
                                    : Colors.transparent,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: Image(
                                      image: AssetImage(ingredient.imageUrl!),
                                    ),
                                  ),
                                  Text(ingredient.name!)
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
