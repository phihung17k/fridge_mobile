import 'package:flutter/material.dart';
import 'package:fridge_mobile/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  bool _isLoading = true;

  late final TabController tabController;
  late final PageController pageController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // bloc.loadIngredients();

    pageController = PageController();
    tabController = TabController(length: 2, vsync: this);

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
    // double widthPer3 = MediaQuery.sizeOf(context).width / 3;
    super.build(context); // Must call super.build when using AutomaticKeepAliveClientMixin
    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                // Theme.of(context).colorScheme.secondary,
                // Theme.of(context).colorScheme.secondaryContainer
                Color.fromARGB(255, 93, 185, 150),
                Color.fromARGB(255, 227, 240, 175),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              // tileMode: TileMode.mirror,
              // stops: [0.4, 1],
            ),
          ),
          child: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inverseSurface.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 30,
              children: [
                Text(
                  "Craft Delicious Meals with What You Have!",
                  textAlign: TextAlign.center,
                  maxLines: null,
                  style: TextTheme.of(context).headlineMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onInverseSurface,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: PageView.builder(
                          controller: pageController,
                          itemCount: 2,
                          onPageChanged: (value) {
                            tabController.animateTo(value);
                          },
                          itemBuilder: (context, index) {
                            String imageName =
                                index == 0 ? "ice_cream.jpg" : "chocolate-molten.jpg";
                            return Image(
                              image: AssetImage("assets/images/$imageName"),
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        child: TabPageSelector(
                          controller: tabController,
                          color: Theme.of(context).colorScheme.surface,
                          selectedColor: Theme.of(context).colorScheme.inversePrimary,
                          // indicatorSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.cooking);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: Text(
                    "Get started",
                    style: TextTheme.of(context).bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      // appBar:
      // AppBar(
      //   toolbarHeight: 70,
      //   leading: const Image(
      //     image: ExactAssetImage("assets/images/man.png", scale: 1.5),
      //   ),
      //   title: const Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text("Good morning"),
      //       Text(
      //         "ABC",
      //         style: TextStyle(fontWeight: FontWeight.bold),
      //       ),
      //     ],
      //   ),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.notifications_outlined),
      //       onPressed: () {},
      //     )
      //   ],
      // ),
      // body: Padding(
      //   padding: const EdgeInsets.all(10.0),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Text(
      //             "Cookbooks",
      //             style: Theme.of(context)
      //                 .textTheme
      //                 .titleMedium
      //                 ?.copyWith(fontWeight: FontWeight.bold),
      //           ),
      //           const Text("1/3")
      //         ],
      //       ),
      //       Card(
      //         color: Colors.white,
      //         child: SizedBox(
      //           width: double.maxFinite,
      //           child: Padding(
      //             padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      //             child: Column(
      //               children: [
      //                 RepaintBoundary(
      //   child: ShimmerLoading(
      //     isLoading: _isLoading,
      //     child: Image.asset(
      //       "assets/images/lean_pork.png",
      //       width: widthPer3,
      //       cacheWidth: widthPer3.round(),
      //     ),
      //   ),
      // ),
      //                 Text(
      //                   "Thịt lợn tươi sống tái chanh năm 1999",
      //                   style: Theme.of(context)
      //                       .textTheme
      //                       .titleMedium
      //                       ?.copyWith(fontWeight: FontWeight.bold),
      //                 ),
      //                 Padding(
      //                   padding: const EdgeInsets.symmetric(vertical: 12.0),
      //                   child: Text(
      //                     StringConstant.recipeDescriptionSample,
      //                     textAlign: TextAlign.center,
      //                   ),
      //                 ),
      //                 const Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                   children: [
      //                     Row(children: [Icon(Icons.group), Text("4 persons")]),
      //                     Row(children: [Icon(Icons.access_time_rounded), Text("20 min")]),
      //                     Row(children: [
      //                       Icon(Icons.local_fire_department_outlined),
      //                       Text("150 kcal")
      //                     ]),
      //                   ],
      //                 )
      //               ],
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
