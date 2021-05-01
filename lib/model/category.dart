import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class Category {
  final String id;
  final String name;
  final String imageURL;

  const Category({this.id, @required this.name, @required this.imageURL});

  Map<String, dynamic> toDocument() {
    return {'name': name, 'imageURL': imageURL};
  }

  factory Category.fromSnapshot(DocumentSnapshot doc) {
    return Category(
      id: doc.documentID,
      name: doc.data['name'] ?? '',
      imageURL: doc.data['imageURL'] ?? '',
    );
  }
}
