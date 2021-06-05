import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spraat/services/app_localization.dart';
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
        id: doc.id,
        brand: doc.data()['brand'] ?? '',
        specifications: doc.data()['specifications'] ?? '',
        condition: doc.data()['condition'] ?? '',
        warranty: doc.data()['warranty'],
        validTill: doc.data()['validTill'],
        name: doc.data()['name'],
        price: doc.data()['price'],
        requestID: doc.data()['requestID'],
        imageURL: doc.data()['imageURL'],
        phone: doc.data()['phone'] ?? "",
        userId: doc.data()['userId'] ?? "",
        extra: doc.data()['extra'] ?? []);
  }

  Widget detailsView(BuildContext context) {
    print(toDocument());
    return Column(
      children: [
        this.name == null ? Container() :
        Card(
          child: Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width:
                  MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    AppLocalizations.of(context).translate('name') ?? "Name",
                    style: TextStyle(
                        fontSize: 18, color: Colors.grey[400], fontWeight: FontWeight.w600),
                  ),
                ),
                Text(this.name,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
        this.name == null ? Container() : SizedBox(height: 5),
        // this.name == null
        //     ? Container()
        //     : Row(
        //         children: [
        //           Container(
        //             width: MediaQuery.of(context).size.width * 0.4,
        //             child: Text(
        //               "name",
        //               style:
        //                   TextStyle(fontSize: 18, color: Colors.grey[400], fontWeight: FontWeight.w600),
        //             ),
        //           ),
        //           Container(
        //             width: MediaQuery.of(context).size.width * 0.5,
        //             child: Text(
        //               this.name ?? "",
        //               style:
        //                   TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        //             ),
        //           ),
        //         ],
        //       ),
        // this.name != null ? Divider() : Container(),
        // this.brand == null
        //     ? Container()
        //     : Row(
        //         children: [
        //           Container(
        //             width: MediaQuery.of(context).size.width * 0.4,
        //             child: Text(
        //               "brand",
        //               style:
        //                   TextStyle(fontSize: 18, color: Colors.grey[400], fontWeight: FontWeight.w600),
        //             ),
        //           ),
        //           Container(
        //             width: MediaQuery.of(context).size.width * 0.5,
        //             child: Text(
        //               this.brand ?? "",
        //               style:
        //                   TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        //             ),
        //           ),
        //         ],
        //       ),
        // this.brand != null ? Divider() : Container(),
        this.brand == null ? Container() :
        Card(
          child: Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width:
                  MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    AppLocalizations.of(context).translate('brand') ?? "Brand",
                    style: TextStyle(
                        fontSize: 18, color: Colors.grey[400], fontWeight: FontWeight.w600),
                  ),
                ),
                Text(this.brand,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
        this.brand == null ? Container() : SizedBox(height: 5),
        // this.price == null
        //     ? Container()
        //     : Row(
        //         children: [
        //           Container(
        //             width: MediaQuery.of(context).size.width * 0.4,
        //             child: Text(
        //               "price",
        //               style:
        //                   TextStyle(fontSize: 18, color: Colors.grey[400], fontWeight: FontWeight.w600),
        //             ),
        //           ),
        //           Container(
        //             width: MediaQuery.of(context).size.width * 0.5,
        //             child: Text(
        //               this.price ?? "",
        //               style:
        //                   TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        //             ),
        //           ),
        //         ],
        //       ),
        // this.price != null ? Divider() : Container(),
        this.price == null ? Container() :
        Card(
          child: Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width:
                  MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    AppLocalizations.of(context).translate('price') ?? "Price",
                    style: TextStyle(
                        fontSize: 18, color: Colors.grey[400], fontWeight: FontWeight.w600),
                  ),
                ),
                Text(this.price + " BHD",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
        this.price == null ? Container() : SizedBox(height: 5),
        // this.specifications == null
        //     ? Container()
        //     : Row(
        //         children: [
        //           Container(
        //             width: MediaQuery.of(context).size.width * 0.4,
        //             child: Text(
        //               "specifications",
        //               style:
        //                   TextStyle(fontSize: 18, color: Colors.grey[400], fontWeight: FontWeight.w600),
        //             ),
        //           ),
        //           Container(
        //             width: MediaQuery.of(context).size.width * 0.5,
        //             child: Text(
        //               this.specifications ?? "",
        //               style:
        //                   TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        //             ),
        //           ),
        //         ],
        //       ),
        // this.specifications != null ? Divider() : Container(),
        this.specifications == '' ? Container() :
        Card(
          child: Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width:
                  MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    AppLocalizations.of(context).translate('specification') ?? "Specification",
                    style: TextStyle(
                        fontSize: 18, color: Colors.grey[400], fontWeight: FontWeight.w600),
                  ),
                ),
                Text(this.specifications,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
        this.specifications == '' ? Container() : SizedBox(height: 5),
        // this.condition == null
        //     ? Container()
        //     : Row(
        //         children: [
        //           Container(
        //             width: MediaQuery.of(context).size.width * 0.4,
        //             child: Text(
        //               "condition",
        //               style:
        //                   TextStyle(fontSize: 18, color: Colors.grey[400], fontWeight: FontWeight.w600),
        //             ),
        //           ),
        //           Container(
        //             width: MediaQuery.of(context).size.width * 0.5,
        //             child: Text(
        //               this.condition ?? "",
        //               style:
        //                   TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        //             ),
        //           ),
        //         ],
        //       ),
        // this.condition != null ? Divider() : Container(),
        this.condition == '' ? Container() :
        Card(
          child: Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width:
                  MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    AppLocalizations.of(context).translate('condition') ?? "Condition",
                    style: TextStyle(
                        fontSize: 18, color: Colors.grey[400], fontWeight: FontWeight.w600),
                  ),
                ),
                Text(this.condition,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
        this.condition == '' ? Container() : SizedBox(height: 5),
        // this.warranty == null
        //     ? Container()
        //     : Row(
        //         children: [
        //           Container(
        //             width: MediaQuery.of(context).size.width * 0.4,
        //             child: Text(
        //               "warranty",
        //               style:
        //                   TextStyle(fontSize: 18, color: Colors.grey[400], fontWeight: FontWeight.w600),
        //             ),
        //           ),
        //           Container(
        //             width: MediaQuery.of(context).size.width * 0.5,
        //             child: Text(
        //               this.warranty ?? "",
        //               style:
        //                   TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        //             ),
        //           ),
        //         ],
        //       ),
        // this.warranty != null ? Divider() : Container(),
        this.warranty == '' ? Container() :
        Card(
          child: Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width:
                  MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    AppLocalizations.of(context).translate('warranty') ?? "Warranty",
                    style: TextStyle(
                        fontSize: 18, color: Colors.grey[400], fontWeight: FontWeight.w600),
                  ),
                ),
                Text(this.warranty,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
        this.condition == '' ? Container() : SizedBox(height: 5),
        // this.validTill == null
        //     ? Container()
        //     : Row(
        //         children: [
        //           Container(
        //             width: MediaQuery.of(context).size.width * 0.4,
        //             child: Text(
        //               "valid Till",
        //               style:
        //                   TextStyle(fontSize: 18, color: Colors.grey[400], fontWeight: FontWeight.w600),
        //             ),
        //           ),
        //           Container(
        //             width: MediaQuery.of(context).size.width * 0.5,
        //             child: Text(
        //               this.validTill ?? "",
        //               style:
        //                   TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        //             ),
        //           ),
        //         ],
        //       ),
        // this.validTill != null ? Divider() : Container(),
        this.validTill == '' || this.validTill == null? Container() :
        Card(
          child: Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width:
                  MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    AppLocalizations.of(context).translate('validTill') ?? "Valid Until",
                    style: TextStyle(
                        fontSize: 18, color: Colors.grey[400], fontWeight: FontWeight.w600),
                  ),
                ),
                Text(this.validTill,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
        this.validTill == '' || this.validTill == null ? Container() : SizedBox(height: 5),
        // this.imageURL == null
        //     ? Container()
        //     : Row(
        //         children: [
        //           Container(
        //             width: MediaQuery.of(context).size.width * 0.4,
        //             child: Text(
        //               "image",
        //               style:
        //                   TextStyle(fontSize: 18, color: Colors.grey[400], fontWeight: FontWeight.w600),
        //             ),
        //           ),
        //           InkWell(
        //             onTap: () {
        //               Navigator.of(context).push(MaterialPageRoute(
        //                   builder: (context) => ImageView(url: this.imageURL)));
        //             },
        //             child: Container(
        //                 height: 100,
        //                 child: this.imageURL == null
        //                     ? null
        //                     : Image.network(this.imageURL)),
        //           ),
        //         ],
        //       ),
        // this.imageURL != null ? Divider() : Container(),
        this.imageURL == '' || this.imageURL == null ? Container() :
        Card(
          child: Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width:
                  MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    AppLocalizations.of(context).translate('image') ?? "Image",
                    style: TextStyle(
                        fontSize: 18, color: Colors.grey[400], fontWeight: FontWeight.w600),
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
          ),
        ),
        this.imageURL == '' || this.imageURL == null ? Container() : SizedBox(height: 5),
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
                          TextStyle(fontSize: 18, color: Colors.grey[400], fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      e['value'] ?? "",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
