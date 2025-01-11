import 'package:flutter/material.dart';
import 'package:fridge_mobile/blocs/bloc_provider.dart';
import 'package:fridge_mobile/blocs/blocs.dart';
import 'package:fridge_mobile/pages/recipe_form/ingredients_form.dart';
import 'package:fridge_mobile/pages/recipe_form/overview_form.dart';
import 'package:fridge_mobile/pages/recipe_form/steps_form.dart';

import '../base_state.dart';

class RecipeFormPage extends StatefulWidget {
  const RecipeFormPage({super.key});

  @override
  State<RecipeFormPage> createState() => _RecipeFormPageState();
}

class _RecipeFormPageState extends BaseState<RecipeFormPage, RecipeFormBloc> {
  int hour = 0;
  int minute = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget buildContent(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: DefaultTabController(
        length: 3,
        initialIndex: 2,
        child: Form(
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              appBar: AppBar(
                leading: BackButton(
                  onPressed: () => Navigator.pop(context),
                ),
                title: const Text("Recipe Form"),
                forceMaterialTransparency: true,
                // scrolledUnderElevation: 2,
                // surfaceTintColor: Colors.amber,
                actions: [
                  // IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert_outlined)),
                  Builder(builder: (context) {
                    return TextButton(
                      onPressed: () {
                        if (!Form.of(context).validate()) {
                          ScaffoldMessengerState state = ScaffoldMessenger.of(context);
                          state.removeCurrentSnackBar();
                          state.showSnackBar(
                            const SnackBar(
                              content: Text('Processing Data'),
                              duration: Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                      child: const Text("Save"),
                    );
                  }),
                ],
                bottom: const TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: <Widget>[
                    Tab(text: "Overview"),
                    Tab(text: "Ingredients"),
                    Tab(text: "Steps"),
                  ],
                ),
              ),
              body: const TabBarView(
                children: [
                  OverviewForm(),
                  IngredientsForm(),
                  StepsForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
