import 'package:flutter_tut_app/representation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const APP_KEY_LANGUAGE = "APP_KEY_LANGUAGE";

class AppPreferences {
  SharedPreferences sharedPreferences;
  AppPreferences(this.sharedPreferences);

  Future<String> getAppLanguage() async {
    var language = sharedPreferences.getString(APP_KEY_LANGUAGE);
    if (language == null) {
      return LanguageType.ENGLISH.getValue();
    } else {
      return language;
    }
  }
}
