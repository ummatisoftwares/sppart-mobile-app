import 'package:firebase_auth/firebase_auth.dart';
import 'package:spraat/app/locator.dart';
import 'package:spraat/model/brand.dart';
import 'package:spraat/model/category.dart';
import 'package:spraat/model/engine.dart';

import 'package:spraat/model/item.dart';
import 'package:spraat/model/request.dart';
import 'package:spraat/model/type.dart';
import 'package:spraat/model/year.dart';
import 'package:spraat/services/auth_service.dart';
import 'package:spraat/services/firestore_service.dart';
import 'package:spraat/ui/core/views/feed/pages/step0.dart';
import 'package:spraat/ui/core/views/feed/request_preview/request.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class FeedModel extends BaseViewModel {
  final _firestoreService = locator<FirestoreService>();
  final _navigationService = locator<NavigationService>();
  final _auth = locator<AuthService>();
  List<Request> requests = List<Request>();
  List<Item> items = List<Item>();

  Brand selectedBrand;
  CarType selectedtype;
  CarYear selectedYear;
  CarEngine selectedEngine;
  Category selectedCategory;

  init() async {
    setBusy(true);
    FirebaseUser user = await _auth.getUser();
    if (user != null) {
      await getRequests(user.uid);
    }
    setBusy(false);
  }

  getRequests(String userId) async {
    requests = await _firestoreService.retrieveRequests(userId);
    print(userId);
    //print(requests[0].status);
    notifyListeners();
  }

  // getBrand(int index) async {
  //   selectedBrand = await _firestoreService.getBrand(requests[index].carBrand);
  // }
  //
  // getType(int index) async {
  //   selectedtype = await _firestoreService.getCarType(requests[index].carType);
  // }
  //
  // getYear(int index) async {
  //   selectedYear = await _firestoreService.getCarYear(requests[index].carYear);
  // }
  //
  // getEngine(int index) async {
  //   selectedEngine =
  //   await _firestoreService.getCarEngine(requests[index].engineSize);
  // }
  //
  // getCategory(int index) async {
  //   selectedCategory =
  //   await _firestoreService.getCategory(requests[index].category);
  // }

  addRequest() {
    _navigationService.navigateToView(Step0());
  }

  previewRequest(Request req) {
    _navigationService.navigateToView(
      RequestPreview(selectedRequest: req),
    );
  }
}
