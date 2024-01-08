import 'package:flutter_tut_app/representation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore_for_file: constant_identifier_names
const PRESS_KEY_LANGUAGE = "PRESS_KEY_LANGUAGE";
const PRESS_KEY_LOGGED_IN = "PRESS_KEY_LOGGED_IN";
const PRESS_KEY_ONBOARDING = "PRESS_KEY_ONBOARDING";

class AppPreferences {
  SharedPreferences sharedPreferences;
  AppPreferences(this.sharedPreferences);

  Future<String> getAppLanguage() async {
    var language = sharedPreferences.getString(PRESS_KEY_LANGUAGE);
    if (language == null) {
      return LanguageType.ENGLISH.getValue();
    } else {
      return language;
    }
  }

  Future<void> setOnboardingViewed() async {
    sharedPreferences.setBool(PRESS_KEY_ONBOARDING, true);
  }

  Future<bool> isOnboardingViewed() async {
    return sharedPreferences.getBool(PRESS_KEY_ONBOARDING) ?? false;
  }

  Future<void> setUserLoggedIn() async {
    sharedPreferences.setBool(PRESS_KEY_LOGGED_IN, true);
  }

  Future<bool> isUserLoggedIn() async {
    return sharedPreferences.getBool(PRESS_KEY_LOGGED_IN) ?? false;
  }
}
