import 'package:flutter/material.dart';
import 'dependencies/app_dependency.dart';
import 'material-theme/theme.dart';
import 'material-theme/util.dart';
import 'routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppDependencies.setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    // Retrieves the default theme for the platform
    // TextTheme textTheme = Theme.of(context).textTheme;

    // Use with Google Fonts package to use downloadable fonts
    TextTheme textTheme = createTextTheme(context, "Lato", "Lato");

    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      title: "Fridge",
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.main,
      onGenerateRoute: (settings) => Routes.getRoutes(settings),
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      // navigatorObservers: [],
    );
  }
}
