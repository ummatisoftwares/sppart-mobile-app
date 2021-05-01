import 'package:flutter/material.dart';
import 'package:spraat/services/app_localization.dart';
import 'package:spraat/ui/core/model.dart';
import 'package:stacked/stacked.dart';

class CoreView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CoreModel>.reactive(
      onModelReady: (model) => model.init(),
      viewModelBuilder: () => CoreModel(),
      builder: (context, model, child) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: model.currentIndex,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            onTap: (value) => model.switchPage(value),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.rss_feed),
                  label: AppLocalizations.of(context).translate('feed')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  label: AppLocalizations.of(context).translate('cart')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: AppLocalizations.of(context).translate('profile')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.attach_money),
                  label: AppLocalizations.of(context).translate('orders')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: AppLocalizations.of(context).translate('settings'))
            ],
          ),
          body: model.currentPage,
        );
      },
    );
  }
}
