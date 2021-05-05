import 'package:auto_route/auto_route.dart';
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

@AdaptiveAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: CoreView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: AuthView),
    MaterialRoute(page: RegisterView),
    MaterialRoute(page: Step1),
    MaterialRoute(page: Step2),
    MaterialRoute(page: Step3),
    MaterialRoute(page: Step4),
  ],
)
class $Router {}
