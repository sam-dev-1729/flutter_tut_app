import 'package:flutter/material.dart';
import 'package:flutter_tut_app/app/app.dart';

class TestApp extends StatefulWidget {
  const TestApp({super.key});

  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  _logState() {
    print(MyApp.appState); // 0
  }

  _updateAppState() {
    MyApp.appState = 10;
    print(MyApp.appState); // 10
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
