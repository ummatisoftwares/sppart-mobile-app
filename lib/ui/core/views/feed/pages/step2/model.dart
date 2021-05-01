import 'package:spraat/app/locator.dart';
import 'package:spraat/app/router.gr.dart';
import 'package:spraat/model/brand.dart';
import 'package:spraat/model/category.dart';
import 'package:spraat/model/engine.dart';
import 'package:spraat/model/type.dart';
import 'package:spraat/model/year.dart';
import 'package:spraat/services/firestore_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class Step2Model extends BaseViewModel {
  final _firestoreService = locator<FirestoreService>();
  final _navigationService = locator<NavigationService>();

  Brand selectedBrand;
  CarType selectedtype;
  CarYear selectedYear;
  CarEngine selectedEngine;
  init({Brand brand, CarType type, CarYear year, CarEngine engine}) {
    selectedBrand = brand;
    selectedtype = type;
    selectedYear = year;
    selectedEngine = engine;
    notifyListeners();
    getCategories();
  }

  List<Category> partCategories = List<Category>();
  getCategories() async {
    partCategories = await _firestoreService.retrievePartCategories();
    notifyListeners();
  }

  selectCategory(Category selected) {
    _navigationService.navigateTo(Routes.step3ViewRoute,
        arguments: Step3Arguments(
            selectedBrand: selectedBrand,
            selectedType: selectedtype,
            selectedYear: selectedYear,
            selectedEngine: selectedEngine,
            selectedCategory: selected));
  }
}
