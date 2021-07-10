import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class CarYear {
  final String id;
  final String name;
  final String type;
  const CarYear({this.id, @required this.name, @required this.type});

  Map<String, dynamic> toDocument() {
    return {'name': name, 'type': type};
  }

  factory CarYear.fromSnapshot(DocumentSnapshot doc) {
    return CarYear(
      id: doc.id,
      name: doc.data()['name'].toString() ?? '',
      type: doc.data()['type'] ?? '',
    );
  }
}
