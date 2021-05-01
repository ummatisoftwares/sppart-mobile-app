import 'package:flutter/material.dart';
import 'package:spraat/app/locator.dart';
import 'package:spraat/model/brand.dart';
import 'package:spraat/services/app_localization.dart';
import 'package:spraat/services/firestore_service.dart';

import 'package:spraat/ui/core/views/feed/pages/step1/step1.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class Step0Model extends BaseViewModel {
  final _firestoreService = locator<FirestoreService>();
  final _navigationService = locator<NavigationService>();
  final _dialog = locator<DialogService>();
  final _snackBar = locator<SnackbarService>();

  List<Brand> brnds = List<Brand>();

  init() {
    getBrands();
  }

  getBrands() async {
    setBusy(true);
    notifyListeners();
    brnds = await _firestoreService.retrieveBrands();
    setBusy(false);
    notifyListeners();
  }

  deleteBrand(Brand selectedBrand) async {
    DialogResponse res = await _dialog.showConfirmationDialog(
        title: "Delete Brand",
        description: "Do you want to delete ${selectedBrand.name} ?",
        cancelTitle: "Cancel",
        confirmationTitle: "YES");

    if (res.confirmed) {
      await _firestoreService.deleteBrand(selectedBrand);
      _snackBar.showSnackbar(message: "Brand Deleted");
    }
  }

  showBrandTypes(Brand brand) {
    _navigationService.navigateToView(Step1(brand: brand));
  }
}

class Step0 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<Step0Model>.reactive(
      viewModelBuilder: () => Step0Model(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context).translate('selectBrand')),
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
              : model.brnds.length == 0
                  ? Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(child: Text("No Brands Available")),
                          IconButton(
                              icon: Icon(Icons.replay),
                              onPressed: () => model.getBrands())
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        return await model.getBrands();
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 8),
                        child: ListView.separated(
                          itemCount: model.brnds.length,
                          separatorBuilder: (BuildContext context, int index) => Divider(thickness: 1),
                          itemBuilder: (context, index) => ListTile(
                              onLongPress: () =>
                                  model.deleteBrand(model.brnds[index]),
                              onTap: () =>
                                  model.showBrandTypes(model.brnds[index]),
                              leading: model.brnds[index].imageURL.isEmpty
                                  ? Container(
                                      color: Colors.grey,
                                      width: 100,
                                      height: 100,
                                      child: Icon(Icons.image),
                                    )
                                  : SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: Image.network(
                                        model.brnds[index].imageURL,
                                      )),
                              title: Text(model.brnds[index].name),
                          ),
                        ),
                      ),
                    ),
        );
      },
    );
  }
}
