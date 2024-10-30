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
          leading: const Image(
            image: ExactAssetImage("assets/images/man.png", scale: 1.5),
          ),
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Good morning"),
              Text(
                "ABC",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined),
              onPressed: () {},
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10, right: 10, bottom: 0, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Cookbooks",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Text("1/3")
                ],
              ),
              Card(
                color: Colors.white,
                child: Container(
                  width: double.maxFinite,
                  height: 200,
                  child: Column(
                    children: [],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
