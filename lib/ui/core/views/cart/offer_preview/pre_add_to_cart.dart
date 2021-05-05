import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spraat/app/locator.dart';
import 'package:spraat/app/router.gr.dart';
import 'package:spraat/model/offer.dart';
import 'package:spraat/services/auth_service.dart';
import 'package:spraat/services/firestore_service.dart';
import 'package:stacked_services/stacked_services.dart';

class OfferDetailsPreBuy extends StatelessWidget {
  final Offer offer;

  const OfferDetailsPreBuy({
    Key key,
    @required this.offer,
  }) : super(key: key);
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
            ],
          ))),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final dial = locator<DialogService>();
          final firestore = locator<FirestoreService>();
          final snackbar = locator<SnackbarService>();
          final auth = locator<AuthService>();
          final nav = locator<NavigationService>();
          var user = await auth.getUser();

          if (user == null) {
            snackbar.showSnackbar(
                message: "Please login to add this to your cart");
          } else {
            DialogResponse res = await dial.showConfirmationDialog(
                description: "Do you want to add this item to your cart ?",
                cancelTitle: "Cancel",
                confirmationTitle: "Yes",
                title: "Add to cart ?");

            if (res.confirmed) {
              await firestore.addToCart(user.uid, offer);
              nav.clearStackAndShow(Routes.coreView);
            } else {}
          }
        },
        icon: Icon(Icons.shopping_cart),
        label: Text("Add to cart"),
      ),
    );
  }
}
