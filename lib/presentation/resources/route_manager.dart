import 'package:flutter/material.dart';
import 'package:flutter_tut_app/presentation/login/login.dart';
import 'package:flutter_tut_app/presentation/onboarding/onboarding.dart';
import 'package:flutter_tut_app/presentation/register/register.dart';
import 'package:flutter_tut_app/presentation/resources/color_manager.dart';
import 'package:flutter_tut_app/presentation/resources/string_manager.dart';
import 'package:flutter_tut_app/presentation/resources/style_manager.dart';
import 'package:flutter_tut_app/presentation/splash/splash.dart';
import 'package:flutter_tut_app/presentation/stored_details/stored_details.dart';

import '../forget_password/forget_password.dart';

class Routes {
  static const String splashRoute = '/';
  static const String onboardingRoute = '/onboarding';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgetPasswordRoute = '/forget/password';
  static const String storedDetailsRoute = '/stored/details';
}

class RouteGenerator {
  static Route<dynamic> getRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => SplashView());
      case Routes.onboardingRoute:
        return MaterialPageRoute(builder: (_) => OnboardingView());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => LoginView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => RegisterView());
      case Routes.forgetPasswordRoute:
        return MaterialPageRoute(builder: (_) => ForgetPasswordView());
      case Routes.storedDetailsRoute:
        return MaterialPageRoute(builder: (_) => StoredDetailsView());

      default:
        return _getUndefinedPage();
    }
  }

  static Route<dynamic> _getUndefinedPage() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text(
            AppStrings.pageNotFound,
            style: getBoldStyle(color: ColorManager.grey),
          ),
        ),
        body: Center(
          child: Text(
            AppStrings.pageNotFound,
            style: getBoldStyle(color: ColorManager.grey),
          ),
        ),
      ),
    );
  }
}
