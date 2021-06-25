import 'package:flutter/material.dart';
import 'package:spraat/model/brand.dart';
import 'package:spraat/services/app_localization.dart';

import 'package:stacked/stacked.dart';

import 'model.dart';

class Step1 extends StatelessWidget {
  final Brand brand;

  const Step1({Key key, this.brand}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<Step1Model>.reactive(
      onModelReady: (model) => model.init(brand),
      viewModelBuilder: () => Step1Model(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
              title:
                  Text(AppLocalizations.of(context).translate('addRequest'))),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context).translate('carType'),
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      height: 50,
                      color: Colors.white12,
                      child: Center(
                          child: DropdownButtonFormField(
                        value: model.selectedtype,
                        iconSize: 30,
                        hint: Text(AppLocalizations.of(context).translate('type') ?? ""),
                        onChanged: (type) => model.changeType(type),
                        items: model.carTypes
                            .map((e) => DropdownMenuItem(
                                  child: Text(e.name),
                                  value: e,
                                ))
                            .toList(),
                      ))),
                  model.loadingType
                      ? Container(
                          width: double.infinity,
                          height: 5,
                          child: LinearProgressIndicator(),
                        )
                      : Container(height: 5),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    AppLocalizations.of(context).translate('yearOfMake'),
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      height: 50,
                      color: Colors.white12,
                      child: Center(
                          child: DropdownButtonFormField(
                        value: model.selectedYear,
                        iconSize: 30,
                        hint: Text(AppLocalizations.of(context).translate('select') ?? ""),
                        onChanged: (year) => model.changeYears(year),
                        items: model.carYears
                            .map((e) => DropdownMenuItem(
                                  child: Text(e.name),
                                  value: e,
                                ))
                            .toList(),
                      ))),
                  model.loadingYears
                      ? Container(
                          width: double.infinity,
                          height: 5,
                          child: LinearProgressIndicator(),
                        )
                      : Container(height: 5),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    AppLocalizations.of(context).translate('engineSize'),
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      height: 50,
                      color: Colors.white12,
                      child: Center(
                          child: DropdownButtonFormField(
                        value: model.selectedEngine,
                        iconSize: 30,
                        hint: Text(AppLocalizations.of(context).translate('select') ?? ""),
                        onChanged: (year) => model.changeEngine(year),
                        items: model.carEngines
                            .map((e) => DropdownMenuItem(
                                  child: Text(e.name),
                                  value: e,
                                ))
                            .toList(),
                      ))),
                  model.loadingEngine
                      ? Container(
                          width: double.infinity,
                          height: 5,
                          child: LinearProgressIndicator(),
                        )
                      : Container(height: 5),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: model.selectedBrand != null &&
                  model.selectedtype != null &&
                  model.selectedYear != null &&
                  model.selectedEngine != null
              ? FloatingActionButton.extended(
                  onPressed: () => model.selectBodyPart(),
                  label:
                      Text(AppLocalizations.of(context).translate('continue')),
                  icon: Icon(Icons.arrow_forward_ios),
                )
              : null,
        );
      },
    );
  }
}
