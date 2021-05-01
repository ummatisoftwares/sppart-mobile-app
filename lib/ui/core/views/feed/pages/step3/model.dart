import 'package:spraat/app/locator.dart';
import 'package:spraat/app/router.gr.dart';
import 'package:spraat/model/brand.dart';
import 'package:spraat/model/category.dart';
import 'package:spraat/model/engine.dart';
import 'package:spraat/model/item.dart';
import 'package:spraat/model/type.dart';
import 'package:spraat/model/year.dart';
import 'package:spraat/services/firestore_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class Step3Model extends BaseViewModel {
  final _firestoreService = locator<FirestoreService>();
  final _navigationService = locator<NavigationService>();
  Brand selectedBrand;
  CarType selectedtype;
  CarYear selectedYear;
  CarEngine selectedEngine;
  Category selectedCategory;

  List<Item> items = List<Item>();

  init(
      {Brand brand,
      CarType type,
      CarYear year,
      CarEngine engine,
      Category category}) {
    selectedBrand = brand;
    selectedtype = type;
    selectedYear = year;
    selectedEngine = engine;
    selectedCategory = category;
    notifyListeners();
    getItems();
  }

  getItems() async {
    setBusy(true);
    items = await _firestoreService.retrieveItems(categoryId: selectedCategory.id);
    Item others = new Item(categoryId: selectedCategory.id, name: "Others", id: "336sSigrJFx48urfhGBK");
    items.add(others);
    notifyListeners();
    setBusy(false);
  }

  selectItem(Item selected) {
    _navigationService.navigateTo(Routes.step4ViewRoute,
        arguments: Step4Arguments(
            selectedBrand: selectedBrand,
            selectedType: selectedtype,
            selectedYear: selectedYear,
            selectedEngine: selectedEngine,
            selectedCategory: selectedCategory,
            selectedItem: selected));
  }
}
