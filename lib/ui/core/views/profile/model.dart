import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spraat/app/locator.dart';
import 'package:spraat/app/router.gr.dart';
import 'package:spraat/services/auth_service.dart';
import 'package:spraat/services/media_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProfileModel extends BaseViewModel {
  final authService = locator<AuthService>();
  final navigationService = locator<NavigationService>();
  final mediaService = locator<MediaService>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  User user;
  bool passwordUpdateEndabled = false;

  init() async {
    setBusy(true);
    user = await authService.getUser();
    if (user != null) {
      nameController.text = user.displayName;
      emailController.text = user.email;
      passwordController.text = "password";
    }

    notifyListeners();
    setBusy(false);
  }

  login() {
    navigationService.clearStackAndShow(Routes.authView);
  }

  updateProfile() async {
    UserInfo User;
    String name = nameController.text;
    await authService.updateUserInfo(name, User.photoURL);
    await user.reload();
    user = await authService.getUser();
    notifyListeners();
  }

  uploadProfileImage() async {
    var file = await mediaService.getGalleryImage();
    if (file is File) {
      String url = await mediaService.uploadFile(file, path: "profiles/");
      UserInfo User;
      String photoURL = url;
      await authService.updateUserInfo(User.displayName, photoURL);
      await user.reload();
      user = await authService.getUser();
    }

    notifyListeners();
  }

  enablePasswordUpdate() {
    passwordUpdateEndabled = true;
    passwordController.text = "";
    notifyListeners();
  }

  updatePassword() {
    authService.changePassword(passwordController.text);
    passwordUpdateEndabled = false;
    notifyListeners();
  }
}
