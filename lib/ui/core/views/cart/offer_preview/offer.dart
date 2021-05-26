import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spraat/app/locator.dart';
import 'package:spraat/model/offer.dart';
import 'package:spraat/services/auth_service.dart';
import 'package:spraat/services/firestore_service.dart';
import 'package:spraat/ui/core/views/cart/offer_preview/maps.dart';
import 'package:spraat/ui/core/views/cart/offer_preview/offer_location.dart';

import 'package:stacked_services/stacked_services.dart';

class OfferDetails extends StatefulWidget {
  final Offer offer;
  final bool preview;

  const OfferDetails({Key key, @required this.offer, this.preview: false})
      : super(key: key);

  @override
  _OfferDetailsState createState() => _OfferDetailsState();
}

LatLng location;

class _OfferDetailsState extends State<OfferDetails> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String number;
    String name;

    return Scaffold(
      appBar: AppBar(
        title: Text("Offer Details"),
      ),
      body: Container(
          margin: EdgeInsets.all(10),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.offer.detailsView(context),
              Divider(),
              SizedBox(height: 12),
              Text(
                "Name",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.name,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp('[a-zA-Z ]')),
                      ],
                      onChanged: (value) => name = value,
                      decoration: InputDecoration(
                          hintText: "Name",
                          icon: Icon(Icons.perm_contact_cal)),
                      // ignore: missing_return
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Name must not be empty";
                        }
                      },
                    ),
                    SizedBox(height: 24),
                    Text(
                      "Contact Info",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp('[0-9]')),
                      ],
                      onChanged: (value) => number = value,
                      decoration: InputDecoration(
                          hintText: "Phone number",
                          icon: Icon(Icons.phone)),
                      // ignore: missing_return
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Phone number must not be empty";
                        }
                        if (value.length != 8) {
                          return "Phone number include 8 numbers";
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              widget.preview
                  ? Container()
                  : Column(
                      children: [
                        Text(
                          "Payment Method",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Row(
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.check_circle,
                                  color: Theme.of(context).accentColor,
                                ),
                                onPressed: () {}),
                            Text("Cash on Delivery")
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.circle,
                                  color: Colors.grey,
                                ),
                                onPressed: null),
                            Text("Benefit (Coming Soon)")
                          ],
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
            ],
          ))),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            if(_formKey.currentState.validate())
              {Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => OfferLocation(number: number ,name: name ,offer: widget.offer)));}
          },
          icon: Icon(Icons.done),
          label: Text("Next"),
      ),
    );
  }
}
