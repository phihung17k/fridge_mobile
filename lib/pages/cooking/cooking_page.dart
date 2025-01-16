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
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: Scaffold(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: DropdownMenu<String>(
                  initialSelection: dump.first,
                  expandedInsets: EdgeInsets.zero,
                  inputDecorationTheme: const InputDecorationTheme(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  ),
                  menuHeight: 300,
                  dropdownMenuEntries: dump.map<DropdownMenuEntry<String>>((v) {
                    return DropdownMenuEntry(value: v, label: v);
                  }).toList()),
            ),
            const Expanded(child: IngredientsInCategory()),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
