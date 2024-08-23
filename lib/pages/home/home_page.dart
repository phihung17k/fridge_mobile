import 'package:flutter/material.dart';
import 'package:fridge_mobile/blocs/bloc_provider.dart';
import 'package:fridge_mobile/pages/home/widgets/ingredient_text_field.dart';
import 'package:fridge_mobile/pages/home/widgets/selected_option_chips.dart';

import '../../blocs/home/home_bloc.dart';
import '../base_state.dart';
import 'widgets/home_body_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeBloc> {
  @override
  void initState() {
    super.initState();
    bloc.loadIngredients();
  }

  @override
  Widget buildContent(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          leading: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
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
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Image(
                image: ExactAssetImage("assets/images/man.png", scale: 1.5),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20, right: 10, bottom: 0, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IngredientTextField(),
              const SelectedOptionChips(),
              const Expanded(
                child: HomeBodyWidget(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
