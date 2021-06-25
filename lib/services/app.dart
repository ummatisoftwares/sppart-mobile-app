import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool isDarkMode = false;

  String lang = "English";
  Locale locale = Locale('en', 'US');
  String unSelectedLangCode() {
    if (locale.languageCode == 'en') {
      return 'ar';
    } else {
      return 'en';
    }
  }

  AppProvider() {
    loadTheme();
    loadLanguage();
  }

  changeLanguage() async {
    final SharedPreferences prefs = await _prefs;
    if (lang == "English") {
      lang = "العربية";
      locale = Locale('ar', 'BH');
      prefs.setBool('isEnglish', false);
    } else {
      lang = "English";
      locale = Locale('en', 'US');
      prefs.setBool('isEnglish', true);
    }

    notifyListeners();
  }

  loadLanguage() async {
    final SharedPreferences prefs = await _prefs;
    bool isEnglish = prefs.getBool('isEnglish');
    if (isEnglish == null) {
      prefs.setBool('isEnglish', true);
    } else {
      if (isEnglish) {
        if (lang == "English") {
          //nothing
        } else {
          changeLanguage();
        }
      } else {
        if (lang == "العربية") {
          //nothing
        } else {
          changeLanguage();
        }
      }
    }
  }

  loadTheme() async {
    final SharedPreferences prefs = await _prefs;
    bool themeIndex = prefs.getBool('isDarkMode');
    if (themeIndex == null) {
      prefs.setBool('isDarkMode', false);
      isDarkMode = false;
    } else {
      isDarkMode = themeIndex;
    }
  }
}
