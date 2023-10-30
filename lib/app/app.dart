import 'package:flutter/material.dart';

import '../presentation/theme_manager.dart';

class MyApp extends StatefulWidget {
  // const MyApp({super.key});
  static int appState = 0;
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
      theme: getTheme(),
    );
  }
}
