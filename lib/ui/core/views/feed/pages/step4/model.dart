import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spraat/app/locator.dart';
import 'package:spraat/app/router.gr.dart';

import 'package:spraat/model/brand.dart';
import 'package:spraat/model/category.dart';
import 'package:spraat/model/engine.dart';
import 'package:spraat/model/item.dart';
import 'package:spraat/model/request.dart';
import 'package:spraat/model/type.dart';
import 'package:spraat/model/year.dart';
import 'package:spraat/services/app_localization.dart';
import 'package:spraat/services/auth_service.dart';
import 'package:spraat/services/firestore_service.dart';
import 'package:spraat/services/media_service.dart';
import 'package:spraat/ui/auth/auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class Step4Model extends BaseViewModel {
  final _firestoreService = locator<FirestoreService>();
  final mediaService = locator<MediaService>();
  final authService = locator<AuthService>();
  final navService = locator<NavigationService>();
  final snackbar = locator<SnackbarService>();
  TextEditingController phoneEditingController = TextEditingController();
  TextEditingController noteEditingController = TextEditingController();
  TextEditingController chassisEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final chassisKey = GlobalKey<FormState>();
  String uploadedImage, chassisNum;
  Brand selectedBrand;
  CarType selectedtype;
  CarYear selectedYear;
  CarEngine selectedEngine;
  Category selectedCategory;
  Item selectedItem;
  Position location;
  bool loadingLocation = false;

  List<String> images = List<String>();

  init(
      {Brand brand,
      CarType type,
      CarYear year,
      CarEngine engine,
      Category category,
      Item item,
      }) async {
    selectedBrand = brand;
    selectedtype = type;
    selectedYear = year;
    selectedEngine = engine;
    selectedCategory = category;
    selectedItem = item;
    await getData();
    notifyListeners();
  }

  uploadCameraImage() async {
    setBusy(true);
    var file = await mediaService.getImageCamera();
    if (file is File) {
      uploadedImage = await mediaService.uploadFile(file, path: "itemRequests/");
      images.add(uploadedImage);
    }
    notifyListeners();
    setBusy(false);
  }

  uploadCameraChassisImage() async {
    setBusy(true);
    var file = await mediaService.getImageCamera();
    if (file is File) {
      uploadedImage = await mediaService.uploadFile(file, path: "chassisNum/");
      chassisNum = uploadedImage;
    }
    notifyListeners();
    setBusy(false);
  }

  uploadGalleryImage() async {
    setBusy(true);
    var file = await mediaService.getGalleryImage();
    if (file is File) {
      uploadedImage = await mediaService.uploadFile(file, path: "itemRequests/");
      images.add(uploadedImage);
    }

    notifyListeners();
    setBusy(false);
  }

  uploadGalleryChassisImage() async {
    setBusy(true);
    var file = await mediaService.getGalleryImage();
    if (file is File) {
      uploadedImage = await mediaService.uploadFile(file, path: "chassisNum/");
      chassisNum = uploadedImage;
    }

    notifyListeners();
    setBusy(false);
  }

  deleteImage(int index) {
    images.removeAt(index);
    notifyListeners();
  }

  deleteChassisImage() {
    chassisNum = null;
    notifyListeners();
  }

  Future determinePosition() async {
    loadingLocation = true;
    notifyListeners();
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      loadingLocation = false;
      notifyListeners();
      snackbar.showSnackbar(message: "Location services are disabled.");
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      loadingLocation = false;
      notifyListeners();
      snackbar.showSnackbar(
          message:
              "Location permissions are permantly denied, we cannot request permissions.");
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        loadingLocation = false;
        notifyListeners();
        snackbar.showSnackbar(
            message:
                "  'Location permissions are denied (actual value: $permission).");
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    location = await Geolocator.getCurrentPosition().catchError((onError) {
      loadingLocation = false;
    });
    loadingLocation = false;
    notifyListeners();
  }

  submitRequest(BuildContext context) async {
    User user = await authService.getUser();
    if (user == null) {
      snackbar.showSnackbar(message: AppLocalizations.of(context).translate('kindlySignupbeforeAddingRequest') ?? "");
      await saveData();
      navService.navigateToView(AuthView(
          selectedBrand: selectedBrand,
          selectedType: selectedtype,
          selectedYear: selectedYear,
          selectedEngine: selectedEngine,
          selectedCategory: selectedCategory,
          selectedItem: selectedItem,
      ));
    } else {
      //if (chassisKey.currentState.validate() && formKey.currentState.validate()) {
      if (formKey.currentState.validate()) {
        setBusy(true);
        User user = await authService.getUser();
        Request req = Request(
            time: Timestamp.now(),
            carBrand: selectedBrand.id,
            carType: selectedtype.id,
            carName: selectedtype.name,
            carModel: selectedYear.name,
            carYear: selectedYear.id,
            engineSize: selectedEngine.id,
            item: selectedItem.id,
            imageURL: images.toString().replaceAll("[", "").replaceAll("]", ""),
            note: noteEditingController.text,
            phoneNumber: phoneEditingController.text,
            category: selectedCategory.id,
            itemName: selectedItem.name,
            offerNum: "0",
            isShow: "",
            //locationURL: location != null ? "https://www.google.com/maps/search/?api=1&query=${location.latitude},${location.longitude}" : null,
            userId: user.uid,
            chassisNum: chassisNum == null? chassisEditingController.text : chassisNum
        );

        _firestoreService.addRequest(req);
        await removeDate();
        print("OK");
        setBusy(false);
      } else {
        print("NOT OK");
        setBusy(false);
      }
    }
  }

  saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('phone', phoneEditingController.text);
    prefs.setString('description', noteEditingController.text);
    prefs.setStringList('images',images);
    prefs.setString('chassis', chassisEditingController.text);
    prefs.setString('chassisNum', chassisNum);
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    phoneEditingController.text = prefs.getString('phone') ?? '';
    noteEditingController.text = prefs.getString('description') ?? '';
    images = prefs.getStringList('images') ?? [];
    chassisEditingController.text = prefs.getString('chassis') ?? '';
    chassisNum = prefs.getString('chassisNum') ?? null;
  }

  removeDate() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('phone');
    prefs.remove('description');
    prefs.remove('images');
    prefs.remove('chassis');
    prefs.remove('chassisNum');
  }
}
