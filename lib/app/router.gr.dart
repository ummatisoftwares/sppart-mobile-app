// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:spraat/ui/splash/splash.dart';
import 'package:spraat/ui/core/core.dart';
import 'package:spraat/ui/login/login.dart';
import 'package:spraat/model/brand.dart';
import 'package:spraat/model/type.dart';
import 'package:spraat/model/year.dart';
import 'package:spraat/model/engine.dart';
import 'package:spraat/model/category.dart';
import 'package:spraat/model/item.dart';
import 'package:spraat/ui/auth/auth.dart';
import 'package:spraat/ui/register/register.dart';
import 'package:spraat/ui/core/views/feed/pages/step1/step1.dart';
import 'package:spraat/ui/core/views/feed/pages/step2/step2.dart';
import 'package:spraat/ui/core/views/feed/pages/step3/step3.dart';
import 'package:spraat/ui/core/views/feed/pages/step4/step4.dart';

abstract class Routes {
  static const splashViewRoute = '/';
  static const coreViewRoute = '/core-view-route';
  static const loginViewRoute = '/login-view-route';
  static const authViewRoute = '/auth-view-route';
  static const registerViewRoute = '/register-view-route';
  static const step1ViewRoute = '/step1-view-route';
  static const step2ViewRoute = '/step2-view-route';
  static const step3ViewRoute = '/step3-view-route';
  static const step4ViewRoute = '/step4-view-route';
  static const all = {
    splashViewRoute,
    coreViewRoute,
    loginViewRoute,
    authViewRoute,
    registerViewRoute,
    step1ViewRoute,
    step2ViewRoute,
    step3ViewRoute,
    step4ViewRoute,
  };
}

class Router extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.splashViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => SplashView(),
          settings: settings,
        );
      case Routes.coreViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => CoreView(),
          settings: settings,
        );
      case Routes.loginViewRoute:
        if (hasInvalidArgs<LoginViewArguments>(args)) {
          return misTypedArgsRoute<LoginViewArguments>(args);
        }
        final typedArgs = args as LoginViewArguments ?? LoginViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => LoginView(
              key: typedArgs.key,
              selectedBrand: typedArgs.selectedBrand,
              selectedType: typedArgs.selectedType,
              selectedYear: typedArgs.selectedYear,
              selectedEngine: typedArgs.selectedEngine,
              selectedCategory: typedArgs.selectedCategory,
              selectedItem: typedArgs.selectedItem),
          settings: settings,
        );
      case Routes.authViewRoute:
        if (hasInvalidArgs<AuthViewArguments>(args)) {
          return misTypedArgsRoute<AuthViewArguments>(args);
        }
        final typedArgs = args as AuthViewArguments ?? AuthViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => AuthView(
              key: typedArgs.key,
              selectedBrand: typedArgs.selectedBrand,
              selectedType: typedArgs.selectedType,
              selectedYear: typedArgs.selectedYear,
              selectedEngine: typedArgs.selectedEngine,
              selectedCategory: typedArgs.selectedCategory,
              selectedItem: typedArgs.selectedItem),
          settings: settings,
        );
      case Routes.registerViewRoute:
        if (hasInvalidArgs<RegisterViewArguments>(args)) {
          return misTypedArgsRoute<RegisterViewArguments>(args);
        }
        final typedArgs =
            args as RegisterViewArguments ?? RegisterViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => RegisterView(
              key: typedArgs.key,
              selectedBrand: typedArgs.selectedBrand,
              selectedType: typedArgs.selectedType,
              selectedYear: typedArgs.selectedYear,
              selectedEngine: typedArgs.selectedEngine,
              selectedCategory: typedArgs.selectedCategory,
              selectedItem: typedArgs.selectedItem),
          settings: settings,
        );
      case Routes.step1ViewRoute:
        if (hasInvalidArgs<Step1Arguments>(args)) {
          return misTypedArgsRoute<Step1Arguments>(args);
        }
        final typedArgs = args as Step1Arguments ?? Step1Arguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) =>
              Step1(key: typedArgs.key, brand: typedArgs.brand),
          settings: settings,
        );
      case Routes.step2ViewRoute:
        if (hasInvalidArgs<Step2Arguments>(args)) {
          return misTypedArgsRoute<Step2Arguments>(args);
        }
        final typedArgs = args as Step2Arguments ?? Step2Arguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => Step2(
              key: typedArgs.key,
              selectedBrand: typedArgs.selectedBrand,
              selectedType: typedArgs.selectedType,
              selectedYear: typedArgs.selectedYear,
              selectedEngine: typedArgs.selectedEngine),
          settings: settings,
        );
      case Routes.step3ViewRoute:
        if (hasInvalidArgs<Step3Arguments>(args)) {
          return misTypedArgsRoute<Step3Arguments>(args);
        }
        final typedArgs = args as Step3Arguments ?? Step3Arguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => Step3(
              key: typedArgs.key,
              selectedBrand: typedArgs.selectedBrand,
              selectedType: typedArgs.selectedType,
              selectedYear: typedArgs.selectedYear,
              selectedEngine: typedArgs.selectedEngine,
              selectedCategory: typedArgs.selectedCategory),
          settings: settings,
        );
      case Routes.step4ViewRoute:
        if (hasInvalidArgs<Step4Arguments>(args)) {
          return misTypedArgsRoute<Step4Arguments>(args);
        }
        final typedArgs = args as Step4Arguments ?? Step4Arguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => Step4(
              key: typedArgs.key,
              selectedBrand: typedArgs.selectedBrand,
              selectedType: typedArgs.selectedType,
              selectedYear: typedArgs.selectedYear,
              selectedEngine: typedArgs.selectedEngine,
              selectedCategory: typedArgs.selectedCategory,
              selectedItem: typedArgs.selectedItem),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//LoginView arguments holder class
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

//AuthView arguments holder class
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

//RegisterView arguments holder class
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

//Step1 arguments holder class
class Step1Arguments {
  final Key key;
  final Brand brand;
  Step1Arguments({this.key, this.brand});
}

//Step2 arguments holder class
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

//Step3 arguments holder class
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

//Step4 arguments holder class
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
