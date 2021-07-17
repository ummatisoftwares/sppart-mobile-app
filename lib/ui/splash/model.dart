import 'package:spraat/app/locator.dart';
import 'package:spraat/app/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  init() async {
    await Future.delayed(Duration(seconds: 2)).then(
        (value) => _navigationService.clearStackAndShow(Routes.coreView));


  }
}
