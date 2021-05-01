import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class CarEngine {
  final String id;
  final String name;
  final String year;
  const CarEngine({this.id, @required this.name, @required this.year});

  Map<String, dynamic> toDocument() {
    return {'name': name, 'year': year};
  }

  factory CarEngine.fromSnapshot(DocumentSnapshot doc) {
    return CarEngine(
      id: doc.documentID,
      name: doc.data['name'] ?? '',
      year: doc.data['year'] ?? '',
    );
  }
}
