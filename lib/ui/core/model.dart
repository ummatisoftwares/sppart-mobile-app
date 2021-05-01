import 'package:flutter/material.dart';
import 'package:spraat/model/request.dart';
import 'package:spraat/ui/core/views/cart/cart.dart';
import 'package:spraat/ui/core/views/feed/feed.dart';
import 'package:spraat/ui/core/views/orders/order.dart';
import 'package:spraat/ui/core/views/profile/profile.dart';
import 'package:spraat/ui/core/views/settings/settings.dart';
import 'package:stacked/stacked.dart';

class CoreModel extends BaseViewModel {
  Widget currentPage = FeedView();
  int currentIndex = 0;
  Request request;

  init() {}

  switchPage(int index) {
    switch (index) {
      case 0:
        currentPage = FeedView();
        currentIndex = 0;
        break;
      case 1:
        currentPage = CartView();
        currentIndex = 1;
        break;
      case 2:
        currentPage = ProfileView();
        currentIndex = 2;
        break;
      case 3:
        currentPage = OrdersView();
        currentIndex = 3;
        break;
      case 4:
        currentPage = SettingsView();
        currentIndex = 4;
        break;
      default:
        currentPage = FeedView();
        currentIndex = 0;
        break;
    }

    notifyListeners();
  }
}
