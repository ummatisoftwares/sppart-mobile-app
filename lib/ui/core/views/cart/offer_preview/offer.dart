import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spraat/app/locator.dart';
import 'package:spraat/model/offer.dart';
import 'package:spraat/services/app_localization.dart';
import 'package:spraat/services/auth_service.dart';
import 'package:spraat/services/firestore_service.dart';
import 'package:spraat/services/maps.dart';
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
        title: Text(AppLocalizations.of(context).translate('offerDetails')),
      ),
      body: Container(
          margin: EdgeInsets.all(10),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.preview ? Container() : SizedBox(height: 16),
              widget.preview ? Container() : Text(AppLocalizations.of(context).translate('contactDetails') ?? "", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Theme.of(context).primaryColor),),
              widget.preview ? Container() : SizedBox(height: 8),
              widget.preview ? Container() :
              Card(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 8),
                      // Text(
                      //   "Name",
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.bold, fontSize: 18),
                      // ),
                      Container(
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[a-zA-Z ]')),
                          ],
                          onChanged: (value) => name = value,
                          decoration: InputDecoration(
                              hintText: AppLocalizations.of(context).translate("name") ?? "",
                              icon: Icon(Icons.perm_contact_cal, color: Theme.of(context).primaryColor,)),
                          // ignore: missing_return
                          validator: (value) {
                            if (value.isEmpty) {
                              return AppLocalizations.of(context).translate("nameRequired") ?? "";
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 12),
                      // Text(
                      //   "Contact Info",
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.bold, fontSize: 18),
                      // ),
                      Container(
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[0-9]')),
                          ],
                          onChanged: (value) => number = value,
                          decoration: InputDecoration(
                              hintText: AppLocalizations.of(context).translate("phoneNumber") ?? "",
                              icon: Icon(Icons.phone, color: Theme.of(context).primaryColor,)),
                          // ignore: missing_return
                          validator: (value) {
                            if (value.isEmpty) {
                              return AppLocalizations.of(context).translate("phoneNumberRequired") ?? "";
                            }
                            if (value.length != 8) {
                              return AppLocalizations.of(context).translate("phoneNumberMustBe") ?? "";
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              widget.preview ? Container() : SizedBox(height: 16),
              widget.preview ? Container() : Text(AppLocalizations.of(context).translate("paymentMethod") ?? "", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Theme.of(context).primaryColor),),
              widget.preview ? Container() : SizedBox(height: 8),
              widget.preview ? Container() : Card(
                    child: Column(
                        children: [
                          SizedBox(height: 12),
                          // Text(
                          //   "Payment Method",
                          //   style: TextStyle(
                          //       fontWeight: FontWeight.bold, fontSize: 18),
                          // ),
                          Row(
                            children: [
                              IconButton(
                                  icon: Icon(
                                    Icons.check_circle,
                                    color: Theme.of(context).accentColor,
                                  ),
                                  onPressed: () {}),
                              Text(AppLocalizations.of(context).translate("cashOnDelivery") ?? "")
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
                              Text(AppLocalizations.of(context).translate("benefit") ?? "", style: TextStyle(color: Colors.grey),)
                            ],
                          ),
                          SizedBox(height: 12),
                        ],
                      ),
                  ),
              widget.preview ? SizedBox(height: 8) : SizedBox(height: 16),
              Text(AppLocalizations.of(context).translate('offer'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Theme.of(context).primaryColor),),
              SizedBox(height: 8),
              widget.offer.detailsView(context),
              SizedBox(height: 12),
            ],
          ))),
      floatingActionButton: widget.preview ? Container()
          :FloatingActionButton.extended(
          onPressed: (){
            if(_formKey.currentState.validate())
              {Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => OfferLocation(number: number ,name: name ,offer: widget.offer)));}
          },
          icon: Icon(Icons.done),
          label: Text(AppLocalizations.of(context).translate("continue") ?? ""),
      ),
    );
  }
}
