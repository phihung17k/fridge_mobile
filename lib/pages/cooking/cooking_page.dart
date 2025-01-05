import 'package:flutter/material.dart';
import 'package:fridge_mobile/blocs/cooking/cooking_bloc.dart';
import 'package:fridge_mobile/pages/base_state.dart';
import 'package:fridge_mobile/pages/cooking/ingredients_in_category.dart';
import 'package:fridge_mobile/routes.dart';
import '../../data/models/ingredient_model.dart';
import 'badge_count.dart';

class CookingPage extends StatefulWidget {
  const CookingPage({super.key});

  @override
  State<CookingPage> createState() => _CookingPageState();
}

class _CookingPageState extends BaseState<CookingPage, CookingBloc>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 6, vsync: this);
    bloc.getIngredients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        bottom: TabBar(
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          padding: EdgeInsets.zero,
          onTap: (value) {},
          tabs: const <Widget>[
            Tab(text: "All"),
            Tab(text: "Category 1"),
            Tab(text: "Category 2"),
            Tab(text: "Category 3"),
            Tab(text: "Category 4"),
            Tab(text: "Category 5"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          StreamBuilder<List<IngredientModel>>(
              stream: bloc.ingredientListStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return IngredientsInCategory(ingredients: snapshot.data!);
              }),
          SizedBox(),
          SizedBox(),
          SizedBox(),
          SizedBox(),
          SizedBox()
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
