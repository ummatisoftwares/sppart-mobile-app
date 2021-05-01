import 'package:flutter/material.dart';

import 'package:spraat/model/brand.dart';
import 'package:spraat/model/category.dart';
import 'package:spraat/model/engine.dart';
import 'package:spraat/model/type.dart';
import 'package:spraat/model/year.dart';
import 'package:spraat/services/app_localization.dart';

import 'package:stacked/stacked.dart';

import 'model.dart';

class Step3 extends StatelessWidget {
  final Brand selectedBrand;
  final CarType selectedType;
  final CarYear selectedYear;
  final CarEngine selectedEngine;
  final Category selectedCategory;

  const Step3(
      {Key key,
      this.selectedBrand,
      this.selectedType,
      this.selectedYear,
      this.selectedEngine,
      this.selectedCategory})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<Step3Model>.reactive(
      onModelReady: (model) => model.init(
          brand: selectedBrand,
          type: selectedType,
          year: selectedYear,
          engine: selectedEngine,
          category: selectedCategory),
      viewModelBuilder: () => Step3Model(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
              title: Text(
                  AppLocalizations.of(context).translate('selectItem') ?? "")),
          body: model.isBusy
              ? Container(
                  child: Center(
                      child: Container(
                    height: 5,
                    width: 50,
                    child: LinearProgressIndicator(),
                  )),
                )
              : model.items.length == 0
                  ? Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(child: Text("No Items Available")),
                          IconButton(
                              icon: Icon(Icons.replay),
                              onPressed: () => model.getItems())
                        ],
                      ),
                    )
                  : Container(
                      child: ListView.separated(
                        itemCount: model.items.length,
                        separatorBuilder: (BuildContext context, int index) => Divider(thickness: 1),
                        itemBuilder: (context, index) => ListTile(
                          onTap: () => model.selectItem(model.items[index]),
                          title: Text(model.items[index].name),
                        ),
                      ),
                    ),
        );
      },
    );
  }
}
