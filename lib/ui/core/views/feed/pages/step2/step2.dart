import 'package:flutter/material.dart';
import 'package:spraat/model/brand.dart';
import 'package:spraat/model/engine.dart';
import 'package:spraat/model/type.dart';
import 'package:spraat/model/year.dart';
import 'package:spraat/services/app_localization.dart';

import 'package:stacked/stacked.dart';

import 'model.dart';

class Step2 extends StatelessWidget {
  final Brand selectedBrand;
  final CarType selectedType;
  final CarYear selectedYear;
  final CarEngine selectedEngine;

  const Step2(
      {Key key,
      this.selectedBrand,
      this.selectedType,
      this.selectedYear,
      this.selectedEngine})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<Step2Model>.reactive(
      onModelReady: (model) => model.init(
          brand: selectedBrand,
          type: selectedType,
          year: selectedYear,
          engine: selectedEngine),
      viewModelBuilder: () => Step2Model(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
              title: Text(
                  AppLocalizations.of(context).translate('selectCategory'))),
          body: Container(
              child: model.partCategories.length > 0
                  ? ListView.builder(
                      itemCount: model.partCategories.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () =>
                              model.selectCategory(model.partCategories[index]),
                          child: Card(
                            child: Container(
                              height: 80,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    model.partCategories[index].name,
                                    style: TextStyle(fontSize: 22),
                                  ),
                                  Image.network(
                                    model.partCategories[index].imageURL,
                                    fit: BoxFit.cover,
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                  : Container(
                      child: Center(
                          child: Container(
                        height: 5,
                        width: 50,
                        child: LinearProgressIndicator(),
                      )),
                    )),
        );
      },
    );
  }
}
