import 'package:flutter/material.dart';
import 'package:spraat/services/app_localization.dart';

import 'model.dart';
import 'package:stacked/stacked.dart';

class CartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CartModel>.reactive(
      onModelReady: (model) => model.init(),
      viewModelBuilder: () => CartModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context).translate('cart'),
            ),
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
              : model.user == null
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context).translate('youAreNotLoggedIn'),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () => model.login(),
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context).translate('login'),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : model.cart.length == 0
                      ? Center(
                          child: Text(AppLocalizations.of(context).translate('yourCartEmpty')),
                        )
                      : Container(
                        margin: EdgeInsets.all(12),
                        child: ListView.builder(
                            //separatorBuilder: (context, index) => Divider(),
                            itemCount: model.cart.length,
                            itemBuilder: (context, index) =>
                                Card(
                                  child: ListTile(
                                    onTap: () => model.navigate(model.cart[index]),
                                    dense: true,
                                    contentPadding: EdgeInsets.only(left: 16.0, right: 6.0),
                                    title: Text(model.cart[index].name, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
                                    subtitle: Text(model.cart[index].brand),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(model.cart[index].price + " BHD", style: TextStyle(fontWeight: FontWeight.w600,)),
                                        Icon(Icons.navigate_next, color: Theme.of(context).primaryColor,)
                                      ],
                                    ),
                                  ),
                                )
                                // ListTile(
                                //   onTap: () => model.navigate(model.cart[index]),
                                //   onLongPress: () =>
                                //       model.deleteFromCart(model.cart[index]),
                                //   leading: model.cart[index].imageURL == null
                                //       ? Container(
                                //           color: Colors.grey,
                                //           width: 50,
                                //           height: 100,
                                //           child: Icon(Icons.image),
                                //         )
                                //       : Container(
                                //           width: 50,
                                //           child: Image.network(
                                //               model.cart[index].imageURL)),
                                //   title: Text(model.cart[index].name),
                                //   subtitle: Text(model.cart[index].brand),
                                //   trailing: Text(model.cart[index].price),
                                // )
          ),
                      ),
        );
      },
    );
  }
}
