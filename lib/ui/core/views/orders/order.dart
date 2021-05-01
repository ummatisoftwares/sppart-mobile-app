import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spraat/app/locator.dart';
import 'package:spraat/model/offer.dart';

import 'package:spraat/services/app_localization.dart';
import 'package:spraat/services/auth_service.dart';
import 'package:spraat/services/firestore_service.dart';
import 'package:spraat/ui/core/views/cart/offer_preview/offer.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PurchasesModel extends BaseViewModel {
  final fireStore = locator<FirestoreService>();
  final auth = locator<AuthService>();
  final nav = locator<NavigationService>();
  List<Offer> myOffers = [];

  init() async {
    getOrders();
  }

  getOrders() async {
    setBusy(true);
    FirebaseUser user = await auth.getUser();
    if (user != null) {
      myOffers = await fireStore.getMyPurchases(user.uid);
    }
    setBusy(false);
  }

  navigate(Offer offer) {
    nav.navigateToView(OfferDetails(
      offer: offer,
      preview: true,
    ));
  }
}

class OrdersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PurchasesModel>.reactive(
      onModelReady: (model) => model.init(),
      viewModelBuilder: () => PurchasesModel(),
      builder: (context, model, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context).translate('orders')),
            ),
            body: model.isBusy
                ? Container(
                    child: Center(
                        child: Container(
                      height: 5,
                      width: 50,
                      child: LinearProgressIndicator(),
                    )),
                  )
                : model.myOffers.length == 0
                    ? Center(
                        child: Text("No Orders"),
                      )
                    : Container(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () =>
                                  model.navigate(model.myOffers[index]),
                              leading: Text(
                                model.myOffers[index].name,
                              ),
                              trailing: Text(model.myOffers[index].price),
                            );
                          },
                          itemCount: model.myOffers.length,
                        ),
                      ));
      },
    );
  }
}
