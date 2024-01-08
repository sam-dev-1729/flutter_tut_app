import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tut_app/representation/resources/assets_manager.dart';
import 'package:flutter_tut_app/representation/resources/color_manager.dart';
import 'package:flutter_tut_app/representation/resources/routes_manager.dart';
import 'package:flutter_tut_app/representation/resources/values_manager.dart';

import '../../app/app_prefs.dart';
import '../../app/di.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  AppPreferences _appPreferences = instance<AppPreferences>();

  late Timer timer;
  _delay() {
    timer = Timer(Duration(milliseconds: DurationConstant.d2000), _goNext);
  }

  _goNext() {
    _appPreferences.isUserLoggedIn().then((isUserLoggedIn) {
      if (isUserLoggedIn) {
        Navigator.pushReplacementNamed(context, Routes.mainRoute);
      } else {
        _appPreferences.isOnboardingViewed().then((isViewed) {
          if (isViewed) {
            Navigator.pushReplacementNamed(context, Routes.loginRoute);
          } else {
            Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
          }
        });
      }
    });
  }

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
