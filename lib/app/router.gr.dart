// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../model/brand.dart';
import '../model/category.dart';
import '../model/engine.dart';
import '../model/item.dart';
import '../model/type.dart';
import '../model/year.dart';
import '../ui/auth/auth.dart';
import '../ui/core/core.dart';
import '../ui/core/views/feed/pages/step1/step1.dart';
import '../ui/core/views/feed/pages/step2/step2.dart';
import '../ui/core/views/feed/pages/step3/step3.dart';
import '../ui/core/views/feed/pages/step4/step4.dart';
import '../ui/login/login.dart';
import '../ui/register/register.dart';
import '../ui/splash/splash.dart';

class Routes {
  static const String splashView = '/';
  static const String coreView = '/core-view';
  static const String loginView = '/login-view';
  static const String authView = '/auth-view';
  static const String registerView = '/register-view';
  static const String step1 = '/Step1';
  static const String step2 = '/Step2';
  static const String step3 = '/Step3';
  static const String step4 = '/Step4';
  static const all = <String>{
    splashView,
    coreView,
    loginView,
    authView,
    registerView,
    step1,
    step2,
    step3,
    step4,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashView, page: SplashView),
    RouteDef(Routes.coreView, page: CoreView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.authView, page: AuthView),
    RouteDef(Routes.registerView, page: RegisterView),
    RouteDef(Routes.step1, page: Step1),
    RouteDef(Routes.step2, page: Step2),
    RouteDef(Routes.step3, page: Step3),
    RouteDef(Routes.step4, page: Step4),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    SplashView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SplashView(),
        settings: data,
      );
    },
    CoreView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => CoreView(),
        settings: data,
      );
    },
    LoginView: (data) {
      final args = data.getArgs<LoginViewArguments>(
        orElse: () => LoginViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginView(
          key: args.key,
          selectedBrand: args.selectedBrand,
          selectedType: args.selectedType,
          selectedYear: args.selectedYear,
          selectedEngine: args.selectedEngine,
          selectedCategory: args.selectedCategory,
          selectedItem: args.selectedItem,
        ),
        settings: data,
      );
    },
    AuthView: (data) {
      final args = data.getArgs<AuthViewArguments>(
        orElse: () => AuthViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => AuthView(
          key: args.key,
          selectedBrand: args.selectedBrand,
          selectedType: args.selectedType,
          selectedYear: args.selectedYear,
          selectedEngine: args.selectedEngine,
          selectedCategory: args.selectedCategory,
          selectedItem: args.selectedItem,
        ),
        settings: data,
      );
    },
    RegisterView: (data) {
      final args = data.getArgs<RegisterViewArguments>(
        orElse: () => RegisterViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => RegisterView(
          key: args.key,
          selectedBrand: args.selectedBrand,
          selectedType: args.selectedType,
          selectedYear: args.selectedYear,
          selectedEngine: args.selectedEngine,
          selectedCategory: args.selectedCategory,
          selectedItem: args.selectedItem,
        ),
        settings: data,
      );
    },
    Step1: (data) {
      final args = data.getArgs<Step1Arguments>(
        orElse: () => Step1Arguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => Step1(
          key: args.key,
          brand: args.brand,
        ),
        settings: data,
      );
    },
    Step2: (data) {
      final args = data.getArgs<Step2Arguments>(
        orElse: () => Step2Arguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => Step2(
          key: args.key,
          selectedBrand: args.selectedBrand,
          selectedType: args.selectedType,
          selectedYear: args.selectedYear,
          selectedEngine: args.selectedEngine,
        ),
        settings: data,
      );
    },
    Step3: (data) {
      final args = data.getArgs<Step3Arguments>(
        orElse: () => Step3Arguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => Step3(
          key: args.key,
          selectedBrand: args.selectedBrand,
          selectedType: args.selectedType,
          selectedYear: args.selectedYear,
          selectedEngine: args.selectedEngine,
          selectedCategory: args.selectedCategory,
        ),
        settings: data,
      );
    },
    Step4: (data) {
      final args = data.getArgs<Step4Arguments>(
        orElse: () => Step4Arguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => Step4(
          key: args.key,
          selectedBrand: args.selectedBrand,
          selectedType: args.selectedType,
          selectedYear: args.selectedYear,
          selectedEngine: args.selectedEngine,
          selectedCategory: args.selectedCategory,
          selectedItem: args.selectedItem,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// LoginView arguments holder class
class LoginViewArguments {
  final Key key;
  final Brand selectedBrand;
  final CarType selectedType;
  final CarYear selectedYear;
  final CarEngine selectedEngine;
  final Category selectedCategory;
  final Item selectedItem;
  LoginViewArguments(
      {this.key,
      this.selectedBrand,
      this.selectedType,
      this.selectedYear,
      this.selectedEngine,
      this.selectedCategory,
      this.selectedItem});
}

/// AuthView arguments holder class
class AuthViewArguments {
  final Key key;
  final Brand selectedBrand;
  final CarType selectedType;
  final CarYear selectedYear;
  final CarEngine selectedEngine;
  final Category selectedCategory;
  final Item selectedItem;
  AuthViewArguments(
      {this.key,
      this.selectedBrand,
      this.selectedType,
      this.selectedYear,
      this.selectedEngine,
      this.selectedCategory,
      this.selectedItem});
}

/// RegisterView arguments holder class
class RegisterViewArguments {
  final Key key;
  final Brand selectedBrand;
  final CarType selectedType;
  final CarYear selectedYear;
  final CarEngine selectedEngine;
  final Category selectedCategory;
  final Item selectedItem;
  RegisterViewArguments(
      {this.key,
      this.selectedBrand,
      this.selectedType,
      this.selectedYear,
      this.selectedEngine,
      this.selectedCategory,
      this.selectedItem});
}

/// Step1 arguments holder class
class Step1Arguments {
  final Key key;
  final Brand brand;
  Step1Arguments({this.key, this.brand});
}

/// Step2 arguments holder class
class Step2Arguments {
  final Key key;
  final Brand selectedBrand;
  final CarType selectedType;
  final CarYear selectedYear;
  final CarEngine selectedEngine;
  Step2Arguments(
      {this.key,
      this.selectedBrand,
      this.selectedType,
      this.selectedYear,
      this.selectedEngine});
}

/// Step3 arguments holder class
class Step3Arguments {
  final Key key;
  final Brand selectedBrand;
  final CarType selectedType;
  final CarYear selectedYear;
  final CarEngine selectedEngine;
  final Category selectedCategory;
  Step3Arguments(
      {this.key,
      this.selectedBrand,
      this.selectedType,
      this.selectedYear,
      this.selectedEngine,
      this.selectedCategory});
}

/// Step4 arguments holder class
class Step4Arguments {
  final Key key;
  final Brand selectedBrand;
  final CarType selectedType;
  final CarYear selectedYear;
  final CarEngine selectedEngine;
  final Category selectedCategory;
  final Item selectedItem;
  Step4Arguments(
      {this.key,
      this.selectedBrand,
      this.selectedType,
      this.selectedYear,
      this.selectedEngine,
      this.selectedCategory,
      this.selectedItem});
}
