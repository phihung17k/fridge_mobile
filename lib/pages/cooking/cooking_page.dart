import 'package:flutter/material.dart';
import '../../models/ingredient_model.dart';
import 'badge_count.dart';

class CookingPage extends StatefulWidget {
  const CookingPage({super.key});

  @override
  State<CookingPage> createState() => _CookingPageState();
}

class _CookingPageState extends State<CookingPage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 6, vsync: this);
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
            onPressed: () {},
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
        children: [x1, x1, x1, x1, x1, x1],
      ),
    );
  }
}

var x1 = GridView.builder(
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 5,
    crossAxisSpacing: 5,
    mainAxisExtent: 160,
  ),
  shrinkWrap: true,
  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
  itemCount: 35,
  padding: const EdgeInsets.all(10),
  itemBuilder: (context, index) {
    IngredientModel ingredient = const IngredientModel(
        id: 1, imageUrl: "assets/images/broccoli.png", isSelected: true, name: "Test");
    return InkWell(
      // onTap: () => bloc?.selectIngredient(index),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            width: ingredient.isSelected ? 5 : 0.1,
            color: ingredient.isSelected ? Colors.blue : Colors.transparent,
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
