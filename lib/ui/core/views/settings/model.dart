import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:spraat/app/locator.dart';
import 'package:spraat/app/router.gr.dart';

import 'package:spraat/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_themes/stacked_themes.dart';

class SettingsModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final authService = locator<AuthService>();
  FirebaseUser user;
  bool isDarkMode = false;

  init(BuildContext context) async {
    setBusy(true);
    user = await authService.getUser();
    isDarkMode = getThemeManager(context).isDarkMode;

    notifyListeners();
    print(isDarkMode.toString());
    setBusy(false);
  }

  login() {
    navigationService.replaceWith(Routes.authViewRoute);
  }

  logout() async {
    await authService.logout();
    user = await authService.getUser();
    notifyListeners();
  }

  switchThemes(BuildContext context) {
    getThemeManager(context).toggleDarkLightTheme();
    isDarkMode = getThemeManager(context).isDarkMode;
    notifyListeners();
  }

  rateApp() async{

  }
}
