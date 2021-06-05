import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spraat/app/locator.dart';
import 'package:spraat/model/offer.dart';
import 'package:spraat/services/auth_service.dart';
import 'package:spraat/services/firestore_service.dart';
import 'package:spraat/services/maps.dart';
import 'package:stacked_services/stacked_services.dart';

class OfferLocation extends StatefulWidget {
  final String number;
  final String name;
  final Offer offer;

  const OfferLocation({Key key, this.number, this.name, this.offer}) : super(key: key);
  @override
  _OfferLocationState createState() => _OfferLocationState();
}

class _OfferLocationState extends State<OfferLocation> {
  String location;
  LatLng locate;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final areaController = TextEditingController();
  final fieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Location"),
        centerTitle: true,
      ),
      body: Container(
        //margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  Image.asset("assets/maps_img.png", height: MediaQuery.of(context).size.height*0.3),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(margin: EdgeInsets.fromLTRB(0, 28, 24, 28),height: 2, width: 100, color: Colors.blueGrey[200],),
                      //Divider(thickness: 2, indent: 60, endIndent: 60, height: 56,),
                      Text("OR", style: TextStyle( fontSize: 18 ,color: Colors.blueGrey, fontWeight: FontWeight.w500)),
                      Container(margin: EdgeInsets.fromLTRB(24, 28, 0, 28),height: 2, width: 100, color: Colors.blueGrey[200],),
                    ],
                  ),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 24.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: areaController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: "Area",
                                icon: Icon(Icons.location_on)),
                            // ignore: missing_return
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Name must not be empty";
                              }
                            },
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: fieldController,
                            keyboardType: TextInputType.text,
                            onChanged: (value) => location = " ",
                            decoration: InputDecoration(
                                hintText: "Address Field",
                                icon: Icon(Icons.location_city)),
                            // ignore: missing_return
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Address Field must not be empty";
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: MediaQuery.of(context).size.height*0.268,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            side:  BorderSide(color: Theme.of(context).primaryColor, width: 1.5)
                          ),
                        ),
                  onPressed: () async {
                    var result = await Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => Maps()));
                    setState(() {
                      locate = result;
                      location = "https://www.google.com/maps/search/?api=1&query=${locate.latitude},${locate.longitude}";
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(6.0, 12.0, 6.0, 12.0),
                    child: location == null ? Text("Add location", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18)) : Icon(Icons.done, color: Theme.of(context).primaryColor,),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: location == null
          ? null
          : FloatingActionButton.extended(
              onPressed: () async {
                if (locate != null) {
                  final dial = locator<DialogService>();
                  final firestore = locator<FirestoreService>();
                  final auth = locator<AuthService>();
                  location = areaController.text +";"+ fieldController.text;
                  var res = await dial.showConfirmationDialog(
                      cancelTitle: "Cancel",
                      confirmationTitle: "Yes",
                      title: "Purchase item?",
                      description: "Would you like to purchase this item ?");
                  if (res.confirmed) {
                    User user = await auth.getUser();
                    firestore.buyItem(widget.number, widget.name, widget.offer, user.uid, location);
                  }
                }
                else if(_formKey.currentState.validate()){
                  final dial = locator<DialogService>();
                  final firestore = locator<FirestoreService>();
                  final auth = locator<AuthService>();
                  location = areaController.text + ";" + fieldController.text;
                  var res = await dial.showConfirmationDialog(
                      cancelTitle: "Cancel",
                      confirmationTitle: "Yes",
                      title: "Purchase item?",
                      description: "Would you like to purchase this item ?");
                  if (res.confirmed) {
                    User user = await auth.getUser();
                    firestore.buyItem(widget.number, widget.name, widget.offer, user.uid, location);
                  }
                }
              },
              icon: Icon(Icons.shopping_cart),
              label: Text("Buy"),
            ),
    );
  }
}