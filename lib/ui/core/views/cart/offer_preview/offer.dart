import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spraat/app/locator.dart';
import 'package:spraat/model/offer.dart';
import 'package:spraat/services/auth_service.dart';
import 'package:spraat/services/firestore_service.dart';

import 'package:stacked_services/stacked_services.dart';

class OfferDetails extends StatelessWidget {
  final Offer offer;
  final bool preview;

  const OfferDetails({Key key, @required this.offer, this.preview: false})
      : super(key: key);
  static final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String number;

    return Scaffold(
      appBar: AppBar(
        title: Text("Offer Details"),
      ),
      body: Container(
          margin: EdgeInsets.all(10),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              offer.detailsView(context),
              Divider(),
              preview
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
                            Text("Cash")
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
                        Text(
                          "Contact Info",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
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
                      ],
                    ),
            ],
          ))),
      floatingActionButton: preview
          ? null
          : FloatingActionButton.extended(
              onPressed: () async {
                final dial = locator<DialogService>();
                final firestore = locator<FirestoreService>();
                final auth = locator<AuthService>();
                if (_formKey.currentState.validate()) {
                  var res = await dial.showConfirmationDialog(
                      cancelTitle: "Cancel",
                      confirmationTitle: "Yes",
                      title: "Purchase item?",
                      description: "Would you like to purchase this item ?");
                  if (res.confirmed) {
                    User user = await auth.getUser();
                    firestore.buyItem(number, offer, user.uid, offer.requestID);
                  }
                }
              },
              icon: Icon(Icons.shopping_cart),
              label: Text("Buy"),
            ),
    );
  }
}
