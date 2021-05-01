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
        return Scaffold();
      },
    );
  }
}
