import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class Brand {
  final String id;
  final String name;
  final String imageURL;

  const Brand({
    this.id,
    @required this.name,
    @required this.imageURL,
  });

  Map<String, dynamic> toDocument() {
    return {'name': name, 'imageURL': imageURL};
  }

  factory Brand.fromSnapshot(DocumentSnapshot doc) {
    return Brand(
      id: doc.documentID,
      name: doc.data['name'] ?? '',
      imageURL: doc.data['imageURL'] ?? '',
    );
  }
}
