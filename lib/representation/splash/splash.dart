import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tut_app/representation/resources/assets_manager.dart';
import 'package:flutter_tut_app/representation/resources/color_manager.dart';
import 'package:flutter_tut_app/representation/resources/routes_manager.dart';
import 'package:flutter_tut_app/representation/resources/values_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late Timer timer;
  _delay() {
    timer = Timer(Duration(milliseconds: DurationConstant.d2000), _goNext);
  }

  _goNext() => Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);

  @override
  void initState() {
    _delay();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(
        child: Image.asset(ImageAssets.splashLogo),
      ),
    );
  }
}
