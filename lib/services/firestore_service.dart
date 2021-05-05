import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:spraat/app/locator.dart';
import 'package:spraat/app/router.gr.dart';
import 'package:spraat/model/brand.dart';
import 'package:spraat/model/category.dart';
import 'package:spraat/model/engine.dart';
import 'package:spraat/model/item.dart';
import 'package:spraat/model/offer.dart';
import 'package:spraat/model/request.dart';
import 'package:spraat/model/type.dart';
import 'package:spraat/model/year.dart';
import 'package:stacked_services/stacked_services.dart';

@lazySingleton
class FirestoreService {
  final snackbarService = locator<SnackbarService>();
  final navService = locator<NavigationService>();

  final CollectionReference requestsCollectionReference =
      FirebaseFirestore.instance.collection('Requests');
  final CollectionReference offersCollectionReference =
      FirebaseFirestore.instance.collection('Offers');
  final CollectionReference brandsCollectionReference =
      FirebaseFirestore.instance.collection('Brand');
  final CollectionReference typessCollectionReference =
      FirebaseFirestore.instance.collection('Types');
  final CollectionReference yearsCollectionReference =
      FirebaseFirestore.instance.collection('Years');
  final CollectionReference enginesCollectionReference =
      FirebaseFirestore.instance.collection('Engines');
  final CollectionReference purchasesCollectionReference =
      FirebaseFirestore.instance.collection('Purchases');

  final CollectionReference userCollectionReference =
      FirebaseFirestore.instance.collection('Users');

  final CollectionReference partCategoriesCollectionReference =
      FirebaseFirestore.instance.collection('Part_Categories');
  final CollectionReference itemsCollectionReference =
      FirebaseFirestore.instance.collection('Item');

  Future<List<Offer>> getMyPurchases(String userId) async {
    var doc = await purchasesCollectionReference
        .where("userId", isEqualTo: userId).get();
    return doc.docs.map((e) => Offer.fromSnapshot(e)).toList();
  }

  Future<Brand> getBrand(String id) async {
    var doc = await brandsCollectionReference.doc(id).get();
    return Brand.fromSnapshot(doc);
  }

  Future<CarType> getCarType(String id) async {
    var doc = await typessCollectionReference.doc(id).get();
    return CarType.fromSnapshot(doc);
  }

  Future<CarYear> getCarYear(String id) async {
    var doc = await yearsCollectionReference.doc(id).get();
    return CarYear.fromSnapshot(doc);
  }

  Future<CarEngine> getCarEngine(String id) async {
    var doc = await enginesCollectionReference.doc(id).get();
    return CarEngine.fromSnapshot(doc);
  }

  Future<Category> getCategory(String id) async {
    var doc = await partCategoriesCollectionReference.doc(id).get();
    return Category.fromSnapshot(doc);
  }

  Future<Item> getItem(String id) async {
    var doc = await itemsCollectionReference.doc(id).get();
    return Item.fromSnapshot(doc);
  }

  Future<List<Brand>> retrieveBrands() async {
    var docs = await brandsCollectionReference.get();

    return docs.docs.map((e) => Brand.fromSnapshot(e)).toList();
  }

  Future<List<Request>> retrieveRequests(String userId) async {
    if (userId == null) {
      List<Request> requests;
      return requests;
    }

    var docs = await requestsCollectionReference
        .where('userId', isEqualTo: userId)
        .orderBy('time', descending: true)
        .get();

    return docs.docs.map((e) => Request.fromSnapshot(e)).toList();
  }

  Future<List<Request>> retrieveAllRequests() async {
    var docs = await requestsCollectionReference.get();

    return docs.docs.map((e) => Request.fromSnapshot(e)).toList();
  }

  Future<List<CarType>> retrieveCarTypes(String brandId) async {
    if (brandId == null) {
      List<CarType> requests;
      return requests;
    }

    var docs = await typessCollectionReference
        .where('brand', isEqualTo: brandId)
        .get();

    return docs.docs.map((e) => CarType.fromSnapshot(e)).toList();
  }

  Future<List<CarYear>> retrieveCarYears(String typeId) async {
    if (typeId == null) {
      List<CarYear> requests;
      return requests;
    }

    var docs = await yearsCollectionReference
        .where('type', isEqualTo: typeId)
        .get();

    return docs.docs.map((e) => CarYear.fromSnapshot(e)).toList();
  }

  Future<List<CarEngine>> retrieveCarEngines(String yearId) async {
    if (yearId == null) {
      List<CarEngine> requests;
      return requests;
    }

    var docs = await enginesCollectionReference
        .where('year', isEqualTo: yearId)
        .get();

    return docs.docs.map((e) => CarEngine.fromSnapshot(e)).toList();
  }

  Future<List<Category>> retrievePartCategories() async {
    var docs = await partCategoriesCollectionReference.get();

    return docs.docs.map((e) => Category.fromSnapshot(e)).toList();
  }

  Future<List<Item>> retrieveItems({String categoryId}) async {
    if (categoryId == null) {
      var docs = await itemsCollectionReference.get();
      return docs.docs.map((e) => Item.fromSnapshot(e)).toList();
    } else {
      var docs = await itemsCollectionReference
          .where("categoryId", isEqualTo: categoryId)
          .get();
      return docs.docs.map((e) => Item.fromSnapshot(e)).toList();
    }
  }

  Future addCategory(Category category) async {
    if (category.name != null && category.name.length > 3) {
      await partCategoriesCollectionReference.add(category.toDocument());
    } else {
      snackbarService.showSnackbar(
          message: "Category cant be empty or less than 3 characters",
          duration: Duration(seconds: 3));
    }
  }

  Future deleteCategory(Category category) async {
    await partCategoriesCollectionReference
        .doc(category.id)
        .delete()
        .catchError((onError) {
      snackbarService.showSnackbar(
          message: onError.code, duration: Duration(seconds: 3));
    });
  }

  addBrand(Brand brand) async {
    if (brand.name != null && brand.name.length > 3) {
      await brandsCollectionReference.add(brand.toDocument());
    } else {
      snackbarService.showSnackbar(
          message: "Brand name cant be empty or less than 3 characters",
          duration: Duration(seconds: 3));
    }
  }

  Future deleteBrand(Brand brand) async {
    await brandsCollectionReference
        .doc(brand.id)
        .delete()
        .catchError((onError) {
      snackbarService.showSnackbar(
          message: onError.code, duration: Duration(seconds: 3));
    });
  }

  addType(CarType type) async {
    if (type.name != null && type.name.length > 3) {
      await typessCollectionReference.add(type.toDocument());
    } else {
      snackbarService.showSnackbar(
          message: "Car Type name cant be empty or less than 3 characters",
          duration: Duration(seconds: 3));
    }
  }

  Future deleteType(CarType type) async {
    await typessCollectionReference
        .doc(type.id)
        .delete()
        .catchError((onError) {
      snackbarService.showSnackbar(
          message: onError.code, duration: Duration(seconds: 3));
    });
  }

  addYear(CarYear type) async {
    if (type.name != null && type.name.length > 3) {
      await yearsCollectionReference.add(type.toDocument());
    } else {
      snackbarService.showSnackbar(
          message: "Car Year name cant be empty or less than 3 characters",
          duration: Duration(seconds: 3));
    }
  }

  Future deleteYear(CarYear type) async {
    await yearsCollectionReference
        .doc(type.id)
        .delete()
        .catchError((onError) {
      snackbarService.showSnackbar(
          message: onError.code, duration: Duration(seconds: 3));
    });
  }

  addEngine(CarEngine type) async {
    if (type.name != null && type.name.length > 0) {
      await enginesCollectionReference.add(type.toDocument());
    } else {
      snackbarService.showSnackbar(
          message: "Car Engine name cant be empty or less than 3 characters",
          duration: Duration(seconds: 3));
    }
  }

  Future deleteEngine(CarEngine type) async {
    await enginesCollectionReference
        .doc(type.id)
        .delete()
        .catchError((onError) {
      snackbarService.showSnackbar(
          message: onError.code, duration: Duration(seconds: 3));
    });
  }

  addItem(Item type) async {
    if (type.name != null && type.name.length > 3) {
      await itemsCollectionReference.add(type.toDocument());
    } else {
      snackbarService.showSnackbar(
          message: "Item name cant be empty or less than 3 characters",
          duration: Duration(seconds: 3));
    }
  }

  addRequest(Request request) async {
    if (request.carBrand != null &&
        request.carType != null &&
        request.carYear != null &&
        request.engineSize != null
        //&& request.item != null
    ) {
      await requestsCollectionReference
          .add(request.toDocument())
          .whenComplete(() {
        snackbarService.showSnackbar(
            message: "Request Sent!", duration: Duration(seconds: 3));

        navService.clearStackAndShow(Routes.coreView);
      });
    } else {
      snackbarService.showSnackbar(
          message: "Item name cant be empty or less than 3 characters",
          duration: Duration(seconds: 3));
    }
  }

  Future deleteItem(Item type) async {
    await itemsCollectionReference
        .doc(type.id)
        .delete()
        .catchError((onError) {
      snackbarService.showSnackbar(
          message: onError.code, duration: Duration(seconds: 3));
    });
  }

  // addItem(Item type) async {
  //   if (type.name != null && type.name.length > 3) {
  //     await itemsCollectionReference.add(type.toDocument());
  //   } else {
  //     snackbarService.showSnackbar(
  //         message: "Item name cant be empty or less than 3 characters",
  //         duration: Duration(seconds: 3));
  //   }
  // }

  Future<List<Offer>> retrieveOffers(String requestId) async {
    var docs = await offersCollectionReference
        .where('requestID', isEqualTo: requestId)
        .get();

    return docs.docs.map((e) => Offer.fromSnapshot(e)).toList();
  }

  addOffer(Offer offer) async {
    if (offer.name != null && offer.price != null) {
      if (offer.id != null) {
        await offersCollectionReference
            .doc(offer.id)
            .set(offer.toDocument())
            .whenComplete(() {
          snackbarService.showSnackbar(
              message: "Request Sent!", duration: Duration(seconds: 3));
        });
      } else {
        await offersCollectionReference
            .add(offer.toDocument())
            .whenComplete(() {
          snackbarService.showSnackbar(
              message: "Request Sent!", duration: Duration(seconds: 3));
        });
      }
    } else {
      snackbarService.showSnackbar(
          message: "Offer name and price cant be empty",
          duration: Duration(seconds: 3));
    }
  }

  Future deleteOffer(Offer type) async {
    await offersCollectionReference
        .doc(type.id)
        .delete()
        .catchError((onError) {
      snackbarService.showSnackbar(
          message: onError.code, duration: Duration(seconds: 3));
    });
  }

  Future addToCart(String userID, Offer offer) async {
    await userCollectionReference
        .doc(userID)
        .collection('Cart')
        .add(offer.toDocument());
  }

  Future deleteFromCart(String userID, String id) async {
    await userCollectionReference
        .doc(userID)
        .collection('Cart')
        .doc(id)
        .delete();
  }

  getUserCart(String userID) async {
    var docs = await userCollectionReference
        .doc(userID)
        .collection('Cart')
        .get();

    return docs.docs.map((e) => Offer.fromSnapshot(e)).toList();
  }

  buyItem(String phoneNumber, Offer offer, String userID, String requestID) async {
    offer.phone = phoneNumber;
    offer.userId = userID;
    await purchasesCollectionReference.add(offer.toDocument());
    await requestsCollectionReference.doc(requestID).update({"status" : "Completed"});
    await userCollectionReference
        .doc(userID)
        .collection('Cart')
        .doc(offer.id)
        .delete();

    navService.clearStackAndShow(Routes.coreView);
  }

}
