import 'package:firebase_auth/firebase_auth.dart';
import 'package:spraat/app/locator.dart';
import 'package:spraat/app/router.gr.dart';

import 'package:spraat/model/offer.dart';

import 'package:spraat/services/auth_service.dart';
import 'package:spraat/services/firestore_service.dart';
import 'package:spraat/ui/core/views/cart/offer_preview/offer.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CartModel extends BaseViewModel {
  final auth = locator<AuthService>();
  final fire = locator<FirestoreService>();
  final nav = locator<NavigationService>();
  User user;
  List<Offer> cart = List<Offer>();

  init() async {
    setBusy(true);
    user = await auth.getUser();
    if (user != null) {
      cart = await fire.getUserCart(user.uid);
    }
    notifyListeners();
    setBusy(false);
  }

  login() {
    nav.clearStackAndShow(Routes.authView);
  }

  navigate(Offer offer) {
    nav.navigateToView(OfferDetails(offer: offer));
  }

  deleteFromCart(Offer offer) async {
    final dial = locator<DialogService>();

    var res = await dial.showConfirmationDialog(
        cancelTitle: "Cancel",
        confirmationTitle: "Yes",
        title: "Remove item?",
        description: "Would you like to remove this item ?");
    if (res.confirmed) {
      setBusy(true);
      await fire.deleteFromCart(user.uid, offer.id);
      cart = await fire.getUserCart(user.uid);
      notifyListeners();
      setBusy(false);
    }
  }
}
