import 'package:spraat/app/locator.dart';
import 'package:spraat/app/router.gr.dart';
import 'package:spraat/model/brand.dart';
import 'package:spraat/model/category.dart';
import 'package:spraat/model/engine.dart';
import 'package:spraat/model/item.dart';
import 'package:spraat/model/type.dart';
import 'package:spraat/model/year.dart';
import 'package:spraat/services/auth_service.dart';
import 'package:spraat/ui/auth/auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final authService = locator<AuthService>();
  Brand selectedBrand;
  CarType selectedtype;
  CarYear selectedYear;
  CarEngine selectedEngine;
  Category selectedCategory;
  Item selectedItem;
  init(
      {Brand brand,
      CarType type,
      CarYear year,
      CarEngine engine,
      Category category,
      Item item}) async {
    selectedBrand = brand;
    selectedtype = type;
    selectedYear = year;
    selectedEngine = engine;
    selectedCategory = category;
    selectedItem = item;
    notifyListeners();
    authService.userStream().listen((event) {
      if (event != null) {
        navigationService.clearStackAndShow(Routes.coreView);
      }
    });
  }

  moveToRegister() {
    navigationService.navigateTo(Routes.registerView,
        arguments: RegisterViewArguments(
            selectedBrand: selectedBrand,
            selectedType: selectedtype,
            selectedYear: selectedYear,
            selectedEngine: selectedEngine,
            selectedCategory: selectedCategory,
            selectedItem: selectedItem));
  }

  moveToLogin() {
    navigationService.navigateTo(Routes.loginView,
        arguments: LoginViewArguments(
            selectedBrand: selectedBrand,
            selectedType: selectedtype,
            selectedYear: selectedYear,
            selectedEngine: selectedEngine,
            selectedCategory: selectedCategory,
            selectedItem: selectedItem));
  }

  moveBack() {
    navigationService.back();
  }
}
