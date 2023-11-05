import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tut_app/presentation/resources/asset_manager.dart';
import 'package:flutter_tut_app/presentation/resources/color_manager.dart';
import 'package:flutter_tut_app/presentation/resources/route_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  _delay() {
    _timer = Timer(const Duration(milliseconds: 2000), _goNext);
  }

  _goNext() => Navigator.pushReplacementNamed(context, Routes.onboardingRoute);

  @override
  void initState() {
    super.initState();
    _delay();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: const Center(
        child: Image(image: AssetImage(ImageAsset.splashLogo)),
      ),
    );
  }
}
