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
    User user = await auth.getUser();
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
                        margin: EdgeInsets.all(12),
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                onTap: () => model.navigate(model.myOffers[index]),
                                dense: true,
                                contentPadding: EdgeInsets.only(left: 16.0, right: 6.0),
                                title: Text(model.myOffers[index].name, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
                                subtitle: Text(model.myOffers[index].brand),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(model.myOffers[index].price + " BHD", style: TextStyle(fontWeight: FontWeight.w600,)),
                                    Icon(Icons.navigate_next, color: Theme.of(context).primaryColor,)
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: model.myOffers.length,
                        ),
                      ));
      },
    );
  }
}
