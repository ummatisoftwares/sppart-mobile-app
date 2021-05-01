import 'package:flutter/material.dart';
import 'package:spraat/ui/splash/model.dart';
import 'package:stacked/stacked.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashModel>.reactive(
      onModelReady: (model) => model.init(),
      viewModelBuilder: () => SplashModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [const Color(0xffFAFBFB), Colors.blueGrey[100]], // red to yellow FAFBFB ECEEEF
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/logo_white.png", height: 180,),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Center(
                      child: CircularProgressIndicator(),
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
