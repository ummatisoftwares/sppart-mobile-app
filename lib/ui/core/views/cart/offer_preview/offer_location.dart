import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spraat/app/locator.dart';
import 'package:spraat/model/offer.dart';
import 'package:spraat/services/app_localization.dart';
import 'package:spraat/services/auth_service.dart';
import 'package:spraat/services/firestore_service.dart';
import 'package:spraat/services/maps.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_themes/stacked_themes.dart';

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
    var isDarkMode = getThemeManager(context).isDarkMode;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("addLocation") ?? ""),
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
                      Text(AppLocalizations.of(context).translate("or") ?? "", style: TextStyle( fontSize: 18 ,color: Colors.blueGrey, fontWeight: FontWeight.w500)),
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
                                hintText: AppLocalizations.of(context).translate("area") ?? "",
                                icon: Icon(Icons.location_on)),
                            // ignore: missing_return
                            validator: (value) {
                              if (value.isEmpty) {
                                return AppLocalizations.of(context).translate("areaRequired") ?? "";
                              }
                            },
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: fieldController,
                            keyboardType: TextInputType.text,
                            onChanged: (value) => location = " ",
                            decoration: InputDecoration(
                                hintText: AppLocalizations.of(context).translate("addressField") ?? "",
                                icon: Icon(Icons.location_city)),
                            // ignore: missing_return
                            validator: (value) {
                              if (value.isEmpty) {
                                return AppLocalizations.of(context).translate("addressFieldRequired") ?? "";
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
                          primary: isDarkMode? Colors.grey[900] : Colors.white,
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
                    child: location == null ? Text(AppLocalizations.of(context).translate("addLocation") ?? "", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18)) : Icon(Icons.done, color: Theme.of(context).primaryColor,),
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
                      cancelTitle: AppLocalizations.of(context).translate("cancel") ?? "",
                      confirmationTitle: AppLocalizations.of(context).translate("yes") ?? "",
                      title: AppLocalizations.of(context).translate("purchaseItem") ?? "" ,
                      description: AppLocalizations.of(context).translate("wouldYouLikeToPurchaseItem") ?? "");
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
                      cancelTitle: AppLocalizations.of(context).translate("cancel") ?? "",
                      confirmationTitle: AppLocalizations.of(context).translate("yes") ?? "",
                      title: AppLocalizations.of(context).translate("purchaseItem") ?? "" ,
                      description: AppLocalizations.of(context).translate("wouldYouLikeToPurchaseItem") ?? "");
                  if (res.confirmed) {
                    User user = await auth.getUser();
                    firestore.buyItem(widget.number, widget.name, widget.offer, user.uid, location);
                  }
                }
              },
              icon: Icon(Icons.shopping_cart),
              label: Text(AppLocalizations.of(context).translate("buy") ?? ""),
            ),
    );
  }
}