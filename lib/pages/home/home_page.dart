import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fridge_mobile/blocs/bloc_provider.dart';
import 'package:fridge_mobile/pages/home/widgets/ingredient_text_field.dart';
import 'package:fridge_mobile/pages/home/widgets/selected_option_chips.dart';

import '../../animations/shimmer_loading.dart';
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

  // @override
  // Widget buildContent(BuildContext context) {
  //   return BlocProvider(
  //     bloc: bloc,
  //     child: Scaffold(
  //       appBar: AppBar(
  //         toolbarHeight: 70,
  //         leading: const Image(
  //           image: ExactAssetImage("assets/images/man.png", scale: 1.5),
  //         ),
  //         title: const Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Text("Good morning"),
  //             Text(
  //               "ABC",
  //               style: TextStyle(fontWeight: FontWeight.bold),
  //             ),
  //           ],
  //         ),
  //         actions: [
  //           IconButton(
  //             icon: const Icon(Icons.notifications_outlined),
  //             onPressed: () {},
  //           )
  //         ],
  //       ),
  //       body: Padding(
  //         padding: const EdgeInsets.only(top: 10, right: 10, bottom: 0, left: 10),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   "Cookbooks",
  //                   style: Theme.of(context)
  //                       .textTheme
  //                       .titleMedium
  //                       ?.copyWith(fontWeight: FontWeight.bold),
  //                 ),
  //                 const Text("1/3")
  //               ],
  //             ),
  //             Card(
  //               color: Colors.white,
  //               child: Container(
  //                 width: double.maxFinite,
  //                 height: 500,
  //                 child: Column(
  //                   children: [
  //                     FadeInImage.assetNetwork(
  //                       placeholder: "assets/images/shimmer_square_loading.gif",
  //                       placeholderColor: Colors.indigo.shade50,
  //                       image: "assets/images/lean_pork.png",
  //                       width: MediaQuery.sizeOf(context).width / 3,
  //                       imageCacheWidth: MediaQuery.sizeOf(context).width / 3 as int,
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  bool _isLoading = true;

  @override
  Widget buildContent(BuildContext context) {
    return ShimmerLoading(
      isLoading: _isLoading,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    'https://docs.flutter.dev/cookbook'
                    '/img-files/effects/split-check/Food1.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
