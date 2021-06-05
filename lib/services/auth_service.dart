import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:injectable/injectable.dart';
import 'package:spraat/app/locator.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:google_sign_in/google_sign_in.dart';

final snackbarService = locator<SnackbarService>();

@lazySingleton
class AuthService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //google
  final googleSignIn = GoogleSignIn();
  //facebook AuthBloc
  final fb = FacebookLogin();
  Stream<User> get currentUser => _firebaseAuth.authStateChanges();
  Future<UserCredential> signInWithCredentail(AuthCredential credential) => _firebaseAuth.signInWithCredential(credential);

  signUpWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      snackbarService.showSnackbar(message: "Register successful");
    } catch (e) {
      snackbarService.showSnackbar(message: "${e.code}");
    }
  }

  Stream<User> userStream() {
    return _firebaseAuth.authStateChanges();
  }

  Future<User> getUser() async {
    return  _firebaseAuth.currentUser;
  }

  login(String email, String password) async {
    UserCredential result;
    if (email.isEmpty ||
        password.isEmpty ||
        password == null ||
        email == null) {
      snackbarService.showSnackbar(
          message: "email or passoword must not be empty");
    } else {
      try {
        result = await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);

        if (result.user != null) {
          snackbarService.showSnackbar(message: "Login successful");
        }
      } catch (e) {
        snackbarService.showSnackbar(message: "${e.code}");
      }
    }

    return result;
  }

  logout() async {

    if (await fb.isLoggedIn) {
      await fb.logOut();
    }
    else if (googleSignIn.currentUser != null){
      await googleSignIn.disconnect();
    }
    await fb.logOut();
    await _firebaseAuth.signOut();
    snackbarService.showSnackbar(message: "logout successful");
  }

  forgotPassword(String email) {
    _firebaseAuth.sendPasswordResetEmail(email: email);
    snackbarService.showSnackbar(
        message:
            "Please check your email for instructions on how to reset your password",
        duration: Duration(seconds: 3));
  }

  updateUserInfo(String name, String photoUrl) async {
    await _firebaseAuth.currentUser.updateProfile(displayName: name, photoURL: photoUrl);
  }

  reloadUser() {}

  changePassword(String newPassword) async {
    try {
      User user = await _firebaseAuth.currentUser;
      user.updatePassword(newPassword).catchError((error) {
        snackbarService.showSnackbar(message: "${error.code}");
      });
      snackbarService.showSnackbar(message: "Password updated succesfully");
    } catch (e) {
      snackbarService.showSnackbar(message: "${e.code}");
    }
  }

}

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  bool _isSigningIn;

  GoogleSignInProvider() {
    _isSigningIn = false;
  }

  bool get isSigningIn => _isSigningIn;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  Future login() async {
    isSigningIn = true;

    final user = await googleSignIn.signIn();
    if (user == null) {
      isSigningIn = false;
      return;
    } else {
      final googleAuth = await user.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      isSigningIn = false;
    }
  }
}

class AuthBloc {
  final authService = AuthService();
  final fb = FacebookLogin();

  Stream<User> get currentUser => authService.userStream();

  loginFacebook() async {
    print('Starting Facebook Login');

    final res = await fb.logIn(
        [
          //FacebookPermission.publicProfile,
          // FacebookPermission.email
        ]
    );

      if(res.status == FacebookLoginStatus.loggedIn)
      {
          print('It worked');

          //Get Token
          final FacebookAccessToken fbToken = res.accessToken;

          //Convert to Auth Credential
          final AuthCredential credential
          = FacebookAuthProvider.credential(fbToken.token);

          //User Credential to Sign in with Firebase
          final result = await authService.signInWithCredentail(credential);

          print('${result.user.displayName} is now logged in');
      }
      if(res.status == FacebookLoginStatus.cancelledByUser)
      {
        print('The user canceled the login');
      }
      if(res.status == FacebookLoginStatus.error)
      {
        print('There was an error');
      }
  }
}


