import 'package:flutter/material.dart';
import 'package:fridge_mobile/blocs/bloc_provider.dart';
import 'package:fridge_mobile/blocs/cooking/cooking_bloc.dart';
import 'package:fridge_mobile/pages/base_state.dart';
import 'package:fridge_mobile/pages/cooking/ingredients_in_category.dart';
import 'package:fridge_mobile/routes.dart';
import '../../data/models/category_model.dart';
import 'badge_count.dart';

class CookingPage extends StatefulWidget {
  const CookingPage({super.key});

  @override
  State<CookingPage> createState() => _CookingPageState();
}

class _CookingPageState extends BaseState<CookingPage, CookingBloc> {
  @override
  void initState() {
    super.initState();
    bloc.getAllCategory();
    bloc.getIngredientsWithCategory();
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
                child: StreamBuilder<(List<CategoryModel>, int?, bool)>(
                    stream: bloc.categories_selectedCategoryId_waitGettingIngredientsStream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data!.$1.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      List<CategoryModel> categories = snapshot.data!.$1;
                      int? selectedCategoryId = snapshot.data!.$2;
                      bool waitGettingIngredient = snapshot.data!.$3;

                      return GridView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: categories.length + 1,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          mainAxisExtent: 100,
                        ),
                        itemBuilder: (context, index) {
                          CategoryModel? category = index > 0 ? categories[index - 1] : null;
                          Color backgroundColor = Theme.of(context).colorScheme.surface;

                          // set background color to the selected category
                          // category = null => "All" button => categoryId = 0
                          if (selectedCategoryId == (category?.id ?? 0)) {
                            backgroundColor = Theme.of(context).colorScheme.inversePrimary;
                          }
                          return ElevatedButton(
                            onPressed: waitGettingIngredient &&
                                    selectedCategoryId != (category?.id ?? 0)
                                ? null
                                : () => bloc.getIngredientsWithCategory(categoryId: category?.id),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              backgroundColor: backgroundColor,
                              disabledBackgroundColor: backgroundColor,
                            ),
                            child: Text(
                              category?.localName ?? "All",
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                      );
                    }),
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
}
