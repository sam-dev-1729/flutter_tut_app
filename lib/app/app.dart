import 'package:flutter/material.dart';

import '../representation/resources/routes_manager.dart';
import '../representation/resources/theme_manager.dart';

class MyApp extends StatefulWidget {
  //const MyApp({super.key});
  int appState = 0;
  MyApp._internal();

  static MyApp get instance => MyApp._internal();

  factory MyApp() => instance;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme(),
    );
  }
}
