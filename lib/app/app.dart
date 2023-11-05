import 'package:flutter/material.dart';
import 'package:flutter_tut_app/presentation/resources/route_manager.dart';

import '../presentation/resources/theme_manager.dart';

class MyApp extends StatefulWidget {
  // const MyApp({super.key});
  int appState = 0;
  bool isDevelopMode = true;
  MyApp._internal();

  static final MyApp instance = MyApp._internal();

  factory MyApp() => instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouteGenerator.getRoutes,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme(),
    );
  }
}
