import 'package:flutter/material.dart';
import 'package:spraat/app/locator.dart';
import 'package:spraat/model/brand.dart';
import 'package:spraat/model/category.dart';
import 'package:spraat/model/engine.dart';
import 'package:spraat/model/item.dart';
import 'package:spraat/model/offer.dart';
import 'package:spraat/model/request.dart';
import 'package:spraat/model/type.dart';
import 'package:spraat/model/year.dart';
import 'package:spraat/services/auth_service.dart';
import 'package:spraat/services/firestore_service.dart';
import 'package:spraat/services/media_service.dart';
import 'package:spraat/ui/core/views/cart/offer_preview/pre_add_to_cart.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RequestPreviewModel extends BaseViewModel {
  final _firestoreService = locator<FirestoreService>();
  final mediaService = locator<MediaService>();
  final authService = locator<AuthService>();
  final snackbar = locator<SnackbarService>();
  final dial = locator<DialogService>();
  final nav = locator<NavigationService>();
  TextEditingController phoneEditingController = TextEditingController();
  TextEditingController noteEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Brand selectedBrand;
  CarType selectedtype;
  CarYear selectedYear;
  CarEngine selectedEngine;
  Category selectedCategory;
  Item selectedItem;

  Request selectedRequest;

  List<Offer> offers = List<Offer>();

  init(String requestID) async {
    setBusy(true);
    selectedRequest = await getRequest(requestID);
    await updateOfferNum();

    await getBrand();
    await getYear();
    await getType();
    await getEngine();
    await getItem();
    await getCategory();
    await getRequestOffers();
    notifyListeners();
    setBusy(false);
  }

  updateOfferNum() async {
    await _firestoreService.requestsCollectionReference.doc(selectedRequest.id).update({"offerNum" : "0"});
    await _firestoreService.requestsCollectionReference.doc(selectedRequest.id).update({"isShow" : ""});
  }

  Future<List<Offer>> getRequestOffers() async {
    offers = await _firestoreService.retrieveOffers(selectedRequest.id);
    return offers;
  }

  Future<Request> getRequest(String requestID) async {
    selectedRequest = await _firestoreService.getRequest(requestID);
    return selectedRequest;
  }

  getBrand() async {
    selectedBrand = await _firestoreService.getBrand(selectedRequest.carBrand);
  }

  getType() async {
    selectedtype = await _firestoreService.getCarType(selectedRequest.carType);
  }

  getYear() async {
    selectedYear = await _firestoreService.getCarYear(selectedRequest.carYear);
  }

  getEngine() async {
    selectedEngine =
        await _firestoreService.getCarEngine(selectedRequest.engineSize);
  }

  getItem() async {
    selectedItem = await _firestoreService.getItem(selectedRequest.item);
  }

  getCategory() async {
    selectedCategory =
        await _firestoreService.getCategory(selectedRequest.category);
  }

  addToCart(Offer offer) async {
    nav.navigateToView(OfferDetailsPreBuy(offer: offer));
    // var user = await authService.getUser();

    // if (user == null) {
    //   snackbar.showSnackbar(message: "Please login to add this to your cart");
    // } else {
    //   DialogResponse res = await dial.showConfirmationDialog(
    //       description: "Do you want to add this item to your cart ?",
    //       cancelTitle: "Cancel",
    //       confirmationTitle: "Yes",
    //       title: "Add to cart ?");

    //   if (res.confirmed) {
    //     _firestoreService.addToCart(user.uid, offer);
    //   } else {}
    // }
  }

  String getImage(index){
     List<String> images = selectedRequest.imageURL.split(", ");
     return images[index];
  }

  int getImageLength(){
    List<String> images = selectedRequest.imageURL.split(", ");
    return images.length;
  }
}
