import 'package:flutter/material.dart';
import 'package:fridge_mobile/blocs/bloc_provider.dart';
import 'package:fridge_mobile/routes.dart';
import 'package:get_it/get_it.dart';
import '../blocs/home/home_bloc.dart';
import 'base_state.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends BaseState<MainPage, HomeBloc> {
  List<(IconData selectedIcon, IconData icon, String label)> destinations = [
    (Icons.home, Icons.home_outlined, "Home"),
    (Icons.local_fire_department, Icons.local_fire_department_outlined, "Cook"),
    (Icons.bookmark, Icons.bookmark_outline, "Saved"),
    (Icons.library_books, Icons.library_books_outlined, "Recipe"),
    (Icons.person, Icons.person_outlined, "Profile")
  ];

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget buildContent(BuildContext context) {
    return BlocProvider(
      bloc: bloc,
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          children: [
            GetIt.I.get<Widget>(instanceName: Routes.home),
            GetIt.I.get<Widget>(instanceName: Routes.cooking),
            GetIt.I.get<Widget>(instanceName: Routes.saved),
            GetIt.I.get<Widget>(instanceName: Routes.recipe),
            GetIt.I.get<Widget>(instanceName: Routes.profile),
          ],
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: NavigationBar(
            onDestinationSelected: (int index) {
              _pageController.jumpToPage(index);
              setState(() {});
            },
            selectedIndex: _pageController.positions.isNotEmpty ? _pageController.page!.toInt() : 0,
            destinations: destinations.map(
              ((IconData, IconData, String) e) {
                return NavigationDestination(
                  selectedIcon: Icon(e.$1),
                  icon: Icon(e.$2),
                  label: e.$3,
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
