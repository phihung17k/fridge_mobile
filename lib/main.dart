import 'package:flutter/material.dart';
import 'dependencies/app_dependencies.dart';
import 'routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppDependencies.setup();

  runApp(MaterialApp(
    title: "Fridge",
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.home,
    onGenerateRoute: (settings) => Routes.getRoutes(settings),
    theme: ThemeData(useMaterial3: true),
    // navigatorObservers: [],
  ));
}
