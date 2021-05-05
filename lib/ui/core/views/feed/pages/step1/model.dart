import 'package:spraat/app/locator.dart';
import 'package:spraat/app/router.gr.dart';
import 'package:spraat/model/brand.dart';
import 'package:spraat/model/engine.dart';
import 'package:spraat/model/type.dart';
import 'package:spraat/model/year.dart';
import 'package:spraat/services/firestore_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class Step1Model extends BaseViewModel {
  final _firestoreService = locator<FirestoreService>();
  final _navigationService = locator<NavigationService>();
  List<Brand> brands = List<Brand>();
  List<CarType> carTypes = List<CarType>();
  List<CarYear> carYears = List<CarYear>();
  List<CarEngine> carEngines = List<CarEngine>();

  bool loadingBrand = true;
  bool loadingType = false;
  bool loadingYears = false;
  bool loadingEngine = false;

  Brand selectedBrand;
  CarType selectedtype;
  CarYear selectedYear;
  CarEngine selectedEngine;
  init(Brand brand) {
    selectedBrand = brand;
    loadTypes();
  }

  getBrands() async {
    loadingBrand = true;
    notifyListeners();
    brands = await _firestoreService.retrieveBrands();
    loadingBrand = false;
    notifyListeners();
  }

  changeBrand(Brand brand) {
    selectedBrand = brand;
    selectedtype = null;
    selectedYear = null;
    selectedEngine = null;
    notifyListeners();
    loadTypes();
  }

  changeType(CarType type) {
    selectedtype = type;
    selectedYear = null;
    selectedEngine = null;
    notifyListeners();
    loadYears();
  }

  changeYears(CarYear year) {
    selectedYear = year;
    selectedEngine = null;
    notifyListeners();
    loadEngines();
  }

  changeEngine(CarEngine engine) {
    selectedEngine = engine;
    notifyListeners();
  }

  loadTypes() async {
    loadingType = true;
    notifyListeners();
    carTypes = await _firestoreService.retrieveCarTypes(selectedBrand.id);
    loadingType = false;
    notifyListeners();
  }

  loadYears() async {
    loadingYears = true;
    notifyListeners();
    carYears = await _firestoreService.retrieveCarYears(selectedtype.id);
    loadingYears = false;
    notifyListeners();
  }

  loadEngines() async {
    loadingEngine = true;
    notifyListeners();
    carEngines = await _firestoreService.retrieveCarEngines(selectedYear.id);
    loadingEngine = false;
    notifyListeners();
  }

  selectBodyPart() {
    _navigationService.navigateTo(Routes.step2,
        arguments: Step2Arguments(
            selectedBrand: selectedBrand,
            selectedEngine: selectedEngine,
            selectedType: selectedtype,
            selectedYear: selectedYear));
  }
}
