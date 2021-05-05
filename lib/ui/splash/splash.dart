import 'package:flutter/material.dart';
import 'package:spraat/app/locator.dart';
import 'package:spraat/ui/splash/model.dart';
import 'package:stacked/stacked.dart';
import 'package:spraat/services/auth_service.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashModel>.reactive(
      onModelReady: (model) => model.init(),
      viewModelBuilder: () => SplashModel(),
      builder: (context, model, child) {
        final _auth = locator<AuthService>();
        _auth.getUser();
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Theme.of(context).primaryColor.withOpacity(0.9), Theme.of(context).primaryColor], // red to yellow FAFBFB ECEEEF
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Image.asset("assets/logo_white.png", height: 180),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.425,
                    child: Center(
                      child: CircularProgressIndicator(backgroundColor: Colors.amber,),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
