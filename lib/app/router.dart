import 'package:auto_route/auto_route_annotations.dart';

import 'package:spraat/ui/auth/auth.dart';
import 'package:spraat/ui/core/core.dart';
import 'package:spraat/ui/core/views/feed/pages/step1/step1.dart';
import 'package:spraat/ui/core/views/feed/pages/step2/step2.dart';
import 'package:spraat/ui/core/views/feed/pages/step3/step3.dart';
import 'package:spraat/ui/core/views/feed/pages/step4/step4.dart';
import 'package:spraat/ui/login/login.dart';
import 'package:spraat/ui/register/register.dart';
import 'package:spraat/ui/splash/splash.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  SplashView splashViewRoute;
  CoreView coreViewRoute;
  LoginView loginViewRoute;
  AuthView authViewRoute;
  RegisterView registerViewRoute;
  Step1 step1ViewRoute;
  Step2 step2ViewRoute;
  Step3 step3ViewRoute;
  Step4 step4ViewRoute;
}
