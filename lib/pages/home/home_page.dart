import 'package:flutter/material.dart';
import 'package:fridge_mobile/animations/shimmer_loading.dart';
import 'package:fridge_mobile/blocs/bloc_provider.dart';
import 'package:fridge_mobile/utils/string_extension.dart';
import '../../blocs/home/home_bloc.dart';
import '../../utils/fridge_mobile_icons.dart';
import '../base_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeBloc> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    bloc.loadIngredients();

    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback(
      (timeStamp) {
        Future.delayed(
          const Duration(seconds: 5),
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
  Widget buildContent(BuildContext context) {
    double widthPer3 = MediaQuery.sizeOf(context).width / 3;
    Color? iconColor = Theme.of(context).iconTheme.color;
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
                child: SizedBox(
                  width: double.maxFinite,
                  height: 500,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        RepaintBoundary(
                          child: ShimmerLoading(
                            isLoading: _isLoading,
                            child: Image.asset(
                              "assets/images/lean_pork.png",
                              width: widthPer3,
                              cacheWidth: widthPer3 as int,
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
                        Text(
                          StringConstant.recipeDescriptionSample,
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          children: [
                            Row(children: [
                              Icon(
                                Icons.group,
                              ),
                              Text("4 persons")
                            ]),
                            Row(children: [Icon(FridgeMobile.timer), Text("4 persons")]),
                            Row(children: [
                              Icon(
                                Icons.group,
                                color: Colors.deepOrange,
                              ),
                              Text("4 persons")
                            ]),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // @override
  // Widget buildContent(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         RepaintBoundary(
  //           child: AspectRatio(
  //             aspectRatio: 16 / 9,
  //             child: ShimmerLoading(
  //               isLoading: _isLoading,
  //               child: Container(
  //                 width: double.infinity,
  //                 decoration: BoxDecoration(
  //                   color: Colors.black,
  //                   borderRadius: BorderRadius.circular(16),
  //                 ),
  //                 child: ClipRRect(
  //                   borderRadius: BorderRadius.circular(16),
  //                   child: Image.network(
  //                     'https://docs.flutter.dev/cookbook'
  //                     '/img-files/effects/split-check/Food1.jpg',
  //                     fit: BoxFit.cover,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
