import 'package:flutter/material.dart';

import '../../animations/shimmer_loading.dart';
import '../../utils/fridge_mobile_icons.dart';
import '../../utils/string_extension.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  bool _isLoading = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // bloc.loadIngredients();

    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback(
      (timeStamp) {
        Future.delayed(
          const Duration(seconds: 1),
          () {
            setState(() {
              _isLoading = false;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double widthPer3 = MediaQuery.sizeOf(context).width / 3;
    super.build(context); // Must call super.build when using AutomaticKeepAliveClientMixin
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBar(
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Cookbooks",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Text("1/3")
          ],
        ),
        Card(
          color: Colors.white,
          child: SizedBox(
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: [
                  RepaintBoundary(
                    child: ShimmerLoading(
                      isLoading: _isLoading,
                      child: Image.asset(
                        "assets/images/lean_pork.png",
                        width: widthPer3,
                        cacheWidth: widthPer3.round(),
                      ),
                    ),
                  ),
                  Text(
                    "Thịt lợn tươi sống tái chanh năm 1999",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      StringConstant.recipeDescriptionSample,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(children: [Icon(Icons.group), Text("4 persons")]),
                      Row(children: [Icon(FridgeMobile.timer), Text("20 min")]),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
