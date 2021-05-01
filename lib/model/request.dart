import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class Request {
  final String id;
  final dynamic time;
  final String carBrand;
  final String carType;
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
      @required this.carYear,
      @required this.engineSize,
      @required this.item,
      @required this.userId,
      this.note,
      this.imageURL,
      @required this.category});

  Map<String, dynamic> toDocument() {
    return {
      'time': time,
      'carBrand': carBrand,
      'carType': carType,
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
    };
  }

  factory Request.fromSnapshot(DocumentSnapshot doc) {
    return Request(
        id: doc.documentID,
        time: doc.data['time'] ?? '',
        carBrand: doc.data['carBrand'] ?? '',
        carType: doc.data['carType'] ?? '',
        carYear: doc.data['carYear'],
        engineSize: doc.data['engineSize'],
        item: doc.data['item'],
        userId: doc.data['userId'],
        note: doc.data['note'],
        imageURL: doc.data['imageURL'],
        replyId: doc.data['replyId'],
        status: doc.data['status'] ?? "Pending",
        category: doc.data['category'],
        locationURL: doc.data['locationURL'],
        itemName: doc.data['itemName'] ?? "Unnamed",
        phoneNumber: doc.data['phoneNumber']);
  }
}
