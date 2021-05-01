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
  FirebaseUser user;
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
    navigationService.clearStackAndShow(Routes.authViewRoute);
  }

  updateProfile() async {
    UserUpdateInfo updateUser = UserUpdateInfo();
    updateUser.displayName = nameController.text;
    await authService.updateUserInfo(updateUser);
    await user.reload();
    user = await authService.getUser();
    notifyListeners();
  }

  uploadProfileImage() async {
    var file = await mediaService.getImage();
    if (file is File) {
      String url = await mediaService.uploadFile(file, path: "profiles/");
      UserUpdateInfo updateUser = UserUpdateInfo();
      updateUser.photoUrl = url;
      await authService.updateUserInfo(updateUser);
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
