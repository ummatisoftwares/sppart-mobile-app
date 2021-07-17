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
  bool canChangePassword = false;
  bool isLoggedInWithFacebook = false;

  init() async {
    setBusy(true);
    user = await authService.getUser();
    if (user != null) {
      nameController.text = user.displayName;
      emailController.text = user.email;
      passwordController.text = "password";
    }
    canChangePassword = await authService.loggedInBy();
    isLoggedInWithFacebook = await authService.loggedInByFacebook();

    notifyListeners();
    setBusy(false);
  }

  login() {
    navigationService.clearStackAndShow(Routes.authView);
  }

  updateProfile() async {
    UserInfo User;
    String name = nameController.text;
    await authService.updateUserInfo(name);
    await user.reload();
    user = await authService.getUser();
    notifyListeners();
    snackbarService.showSnackbar(message: "Profile updated succesfully");
  }

  uploadProfileImage() async {
    var file = await mediaService.getGalleryImage();
    if (file is File) {
      String url = await mediaService.uploadFile(file, path: "profiles/");
      UserInfo User;
      String photoURL = url;
      await authService.updateUserPic(photoURL);
      await user.reload();
      user = await authService.getUser();
      snackbarService.showSnackbar(message: "Profile Picture updated succesfully");
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
    snackbarService.showSnackbar(message: "Password updated succesfully");
    notifyListeners();
  }

  bool canPasswordUpdate() {
   return canChangePassword;
  }
}
