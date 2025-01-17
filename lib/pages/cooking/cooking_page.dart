import 'package:flutter/material.dart';
import 'package:fridge_mobile/blocs/bloc_provider.dart';
import 'package:fridge_mobile/blocs/cooking/cooking_bloc.dart';
import 'package:fridge_mobile/pages/base_state.dart';
import 'package:fridge_mobile/pages/cooking/ingredients_in_category.dart';
import 'package:fridge_mobile/routes.dart';
import 'badge_count.dart';

class CookingPage extends StatefulWidget {
  const CookingPage({super.key});

  @override
  State<CookingPage> createState() => _CookingPageState();
}

class _CookingPageState extends BaseState<CookingPage, CookingBloc>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final List<String> dump = [
    "All",
    "Category 1",
    "Category 2",
    "Category 3",
    "Category 4",
    "Category 5",
    "Category 5",
    "Category 6",
    "Category 7",
    "Category 8",
    "Category 9",
    "Category 10",
    "Category 11",
    "Category 12",
    "Category 13",
    "Category 14",
    "Category 15",
    "Category 16",
    "Category 18"
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: dump.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
          appBar: AppBar(
            title: const Text("Choose Ingredient"),
            // scrolledUnderElevation: 0,
            // surfaceTintColor: Colors.transparent,
            forceMaterialTransparency: true,
            actions: [
              IconButton(
                onPressed: () => Navigator.pushNamed(context, Routes.selectingIngredient),
                icon: BadgeCount(
                  count: 1,
                  child: const Icon(Icons.shopping_bag_outlined),
                ),
                padding: const EdgeInsets.only(right: 10),
              )
            ],
          ),
          body: Column(
            children: [
              SizedBox(
                height: 130,
                // margin: const EdgeInsets.only(bottom: 10),
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: dump.length,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 100,
                  ),
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                      child: Text(dump[index]),
                    );
                  },
                ),
              ),
              const Divider(
                thickness: 1,
                height: 1,
              ),
              const Expanded(child: IngredientsInCategory()),
            ],
          )),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
