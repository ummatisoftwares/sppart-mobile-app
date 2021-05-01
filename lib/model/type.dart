import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class CarType {
  final String id;
  final String name;
  final String brand;
  final String imageURL;
  const CarType(
      {this.imageURL, this.id, @required this.name, @required this.brand});

  Map<String, dynamic> toDocument() {
    return {'name': name, 'brand': brand, 'imageURL': imageURL};
  }

  factory CarType.fromSnapshot(DocumentSnapshot doc) {
    return CarType(
        id: doc.documentID,
        name: doc.data['name'] ?? '',
        brand: doc.data['brand'] ?? '',
        imageURL: doc.data['imageURL'] ?? "");
  }
}
