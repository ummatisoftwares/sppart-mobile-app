import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spraat/ui/core/views/image_preview.dart';

class Offer {
  String id,
      name,
      brand,
      imageURL,
      specifications,
      condition,
      warranty,
      validTill,
      requestID,
      price,
      userId,
      phone;

  List<dynamic> extra = List<dynamic>();

  Offer(
      {this.id,
      this.name,
      this.brand,
      this.imageURL,
      this.specifications,
      this.condition,
      this.warranty,
      this.validTill,
      @required this.requestID,
      this.extra,
      this.phone,
      this.userId,
      this.price});

  Map<String, dynamic> toDocument() {
    return {
      'brand': brand,
      'specifications': specifications,
      'condition': condition,
      'warranty': warranty,
      'validTill': validTill,
      'price': price,
      'name': name,
      'imageURL': imageURL,
      'requestID': requestID,
      'phone': phone,
      'userId': userId,
      'extra':
          extra.map((e) => Field(e["field"], e["value"]).toDocument()).toList()
    };
  }

  factory Offer.fromSnapshot(DocumentSnapshot doc) {
    return Offer(
        id: doc.documentID,
        brand: doc.data['brand'] ?? '',
        specifications: doc.data['specifications'] ?? '',
        condition: doc.data['condition'] ?? '',
        warranty: doc.data['warranty'],
        validTill: doc.data['validTill'],
        name: doc.data['name'],
        price: doc.data['price'],
        requestID: doc.data['requestID'],
        imageURL: doc.data['imageURL'],
        phone: doc.data['phone'] ?? "",
        userId: doc.data['userId'] ?? "",
        extra: doc.data['extra'] ?? []);
  }

  Widget detailsView(BuildContext context) {
    return Column(
      children: [
        this.name == null
            ? Container()
            : Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      "name",
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      this.name ?? "",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
        this.name != null ? Divider() : Container(),
        this.brand == null
            ? Container()
            : Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      "brand",
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      this.brand ?? "",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
        this.brand != null ? Divider() : Container(),
        this.price == null
            ? Container()
            : Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      "price",
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      this.price ?? "",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
        this.price != null ? Divider() : Container(),
        this.specifications == null
            ? Container()
            : Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      "specifications",
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      this.specifications ?? "",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
        this.specifications != null ? Divider() : Container(),
        this.condition == null
            ? Container()
            : Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      "condition",
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      this.condition ?? "",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
        this.condition != null ? Divider() : Container(),
        this.warranty == null
            ? Container()
            : Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      "warranty",
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      this.warranty ?? "",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
        this.warranty != null ? Divider() : Container(),
        this.validTill == null
            ? Container()
            : Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      "valid Till",
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      this.validTill ?? "",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
        this.validTill != null ? Divider() : Container(),
        this.imageURL == null
            ? Container()
            : Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      "image",
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ImageView(url: this.imageURL)));
                    },
                    child: Container(
                        height: 100,
                        child: this.imageURL == null
                            ? null
                            : Image.network(this.imageURL)),
                  ),
                ],
              ),
        this.imageURL != null ? Divider() : Container(),
        Column(
            children: this.extra.map((e) {
          return Column(
            children: [
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      e['field'],
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      e['value'] ?? "",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Divider(),
            ],
          );
        }).toList())
      ],
    );
  }
}

class Field {
  String field;
  String value;

  Field(this.field, this.value);

  Field.fromJson(Map<String, dynamic> json)
      : field = json['field'],
        value = json['value'];

  Map<String, dynamic> toDocument() {
    return {
      'field': field,
      'value': value,
    };
  }
}
