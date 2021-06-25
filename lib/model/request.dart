import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class Request {
  final String id;
  final dynamic time;
  final String carBrand;
  final String carType;
  final String carName;
  final String carModel;
  final String carYear;
  final String engineSize;
  final String item;
  final String note;
  final String imageURL;
  final String userId;
  final String phoneNumber;
  final String status;
  final String replyId;
  final String category;
  final String locationURL;
  final String itemName;
  final String offerNum;
  final String isShow;
  final String chassisNum;

  const Request(
      {this.locationURL,
      this.itemName,
      this.status,
      this.replyId,
      @required this.phoneNumber,
      this.id,
      @required this.time,
      @required this.carBrand,
      @required this.carType,
      @required this.carName,
      @required this.carModel,
      @required this.carYear,
      @required this.engineSize,
      @required this.item,
      @required this.userId,
      this.note,
      this.imageURL,
      this.offerNum,
      this.isShow,
      this.chassisNum,
      @required this.category});

  Map<String, dynamic> toDocument() {
    return {
      'time': time,
      'carBrand': carBrand,
      'carType': carType,
      'carName': carName,
      'carModel': carModel,
      'carYear': carYear,
      'engineSize': engineSize,
      'item': item,
      'userId': userId,
      'note': note,
      'phoneNumber': phoneNumber,
      'imageURL': imageURL,
      'status': status,
      'replyId': replyId,
      'category': category,
      'locationURL': locationURL,
      'itemName': itemName,
      'offerNum': offerNum,
      'isShow': isShow,
      'chassisNum': chassisNum,
    };
  }

  factory Request.fromSnapshot(DocumentSnapshot doc) {
    return Request(
        id: doc.id,
        time: doc.data()['time'] ?? '',
        carBrand: doc.data()['carBrand'] ?? '',
        carType: doc.data()['carType'] ?? '',
        carName: doc.data()['carName'] ?? '',
        carModel: doc.data()['carModel'] ?? '',
        carYear: doc.data()['carYear'],
        engineSize: doc.data()['engineSize'],
        item: doc.data()['item'],
        userId: doc.data()['userId'],
        note: doc.data()['note'],
        imageURL: doc.data()['imageURL'],
        replyId: doc.data()['replyId'],
        status: doc.data()['status'] ?? "Processing",
        category: doc.data()['category'],
        locationURL: doc.data()['locationURL'],
        itemName: doc.data()['itemName'] ?? "Unnamed",
        offerNum: doc.data()['offerNum'] ?? "0",
        isShow: doc.data()['isShow'] ?? "",
        chassisNum: doc.data()['chassisNum'] ?? "",
        phoneNumber: doc.data()['phoneNumber']);
  }
}
