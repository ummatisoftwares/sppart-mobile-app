import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class Item {
  final String id;
  final String categoryId;
  final String name;
  final String imageURL;

  Item({
    this.id,
    @required this.categoryId,
    @required this.name,
    this.imageURL,
  });

  Map<String, dynamic> toDocument() {
    return {
      'categoryId': categoryId,
      'name': name,
      'imageURL': imageURL,
    };
  }

  factory Item.fromSnapshot(DocumentSnapshot doc) {
    return Item(
      id: doc.documentID,
      categoryId: doc.data['categoryId'],
      name: doc.data['name'],
      imageURL: doc.data['imageURL'],
    );
  }
}
