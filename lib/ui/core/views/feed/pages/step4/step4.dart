import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spraat/model/brand.dart';
import 'package:spraat/model/category.dart';
import 'package:spraat/model/engine.dart';
import 'package:spraat/model/item.dart';
import 'package:spraat/model/type.dart';
import 'package:spraat/model/year.dart';
import 'package:spraat/services/app_localization.dart';

import 'package:stacked/stacked.dart';

import 'model.dart';

class Step4 extends StatelessWidget {
  final Brand selectedBrand;
  final CarType selectedType;
  final CarYear selectedYear;
  final CarEngine selectedEngine;
  final Category selectedCategory;
  final Item selectedItem;

  const Step4(
      {Key key,
      this.selectedBrand,
      this.selectedType,
      this.selectedYear,
      this.selectedEngine,
      this.selectedCategory,
      this.selectedItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<Step4Model>.reactive(
      onModelReady: (model) => model.init(
          brand: selectedBrand,
          type: selectedType,
          year: selectedYear,
          engine: selectedEngine,
          category: selectedCategory,
          item: selectedItem),
      viewModelBuilder: () => Step4Model(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
              title: Text(
                  AppLocalizations.of(context).translate('addRequest') ?? "")),
          body: Container(
            margin: EdgeInsets.all(10),
            child: model.isBusy
                ? Container(
                    child: Center(
                        child: Container(
                      height: 5,
                      width: 50,
                      child: LinearProgressIndicator(),
                    )),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Card(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Text(
                                      AppLocalizations.of(context).translate('brand') ?? "",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.grey[400], fontWeight: FontWeight.w600),
                                    )),
                                Text(selectedBrand.name,
                                    style: TextStyle(
                                        fontSize: 18,fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Card(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Text(
                                      AppLocalizations.of(context)
                                              .translate('carType') ??
                                          "",
                                      style: TextStyle(
                                          fontSize: 18,color: Colors.grey[400], fontWeight: FontWeight.w600),
                                    )),
                                Text(selectedType.name,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Card(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Text(
                                      AppLocalizations.of(context)
                                              .translate('yearOfMake') ??
                                          "",
                                      style: TextStyle(
                                          fontSize: 18,color: Colors.grey[400], fontWeight: FontWeight.w600),
                                    )),
                                Text(selectedYear.name,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Card(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Text(
                                      AppLocalizations.of(context)
                                              .translate('engineSize') ??
                                          "",
                                      style: TextStyle(
                                          fontSize: 18,color: Colors.grey[400], fontWeight: FontWeight.w600),
                                    )),
                                Text(selectedEngine.name,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Card(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Text(
                                      AppLocalizations.of(context)
                                              .translate('category') ??
                                          "",
                                      style: TextStyle(
                                          fontSize: 18,color: Colors.grey[400], fontWeight: FontWeight.w600),
                                    )),
                                Text(selectedCategory.name,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Card(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Text(
                                      AppLocalizations.of(context).translate('item') ?? "",
                                      style: TextStyle(fontSize: 18, color: Colors.grey[400], fontWeight: FontWeight.w600),
                                    )),
                                Text(selectedItem.name,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Form(
                          key: model.formKey,
                          child: ListView(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              Divider(),
                              Text(
                                AppLocalizations.of(context).translate('phoneNumber') ?? "",
                                style: TextStyle(fontSize: 18, color: Colors.grey[400], fontWeight: FontWeight.w600),
                              ),
                              Card(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    controller: model.phoneEditingController,
                                    minLines: 1,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Phone number is required';
                                      } else if (value.length < 8) {
                                        return "Phone number must include 8 characters";
                                      }
                                      return null;
                                    },
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ], // Only numbers can be entered
                                    decoration: InputDecoration(
                                        hintText: "Ex. 39123456"),
                                  ),
                                ],
                              )),
                              Divider(),
                              Text(
                                AppLocalizations.of(context)
                                        .translate('desciption') ??
                                    "",
                                style: TextStyle(fontSize: 18, color: Colors.grey[400], fontWeight: FontWeight.w600),
                              ),
                              Card(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    controller: model.noteEditingController,
                                    minLines: 5,
                                    maxLines: 6,
                                    decoration: InputDecoration(
                                        hintText: "Descripe your item "),
                                  ),
                                ],
                              )),
                            ])
                        ),
                        Divider(),
                        model.uploadedImage != null
                            ? Column(
                              children: [
                                ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: model.images.length,
                                itemBuilder: (context, index) => Container(
                                margin:
                                EdgeInsets.symmetric(vertical: 6),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        height: 80,
                                        width: 160,
                                        decoration: BoxDecoration(
                                            color: Colors.grey
                                                .withOpacity(0.2),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  model.images[index],
                                                ),
                                                fit: BoxFit.contain))),
                                    InkWell(
                                      onTap: () => model.deleteImage(index),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.delete,
                                            size: 30,
                                            color: Colors.red,
                                          ),
                                          Text(
                                              AppLocalizations.of(context).translate('delete') ?? "", style: TextStyle(fontWeight: FontWeight.bold)),
                                        ],),
                                      )
                                     ],),
                                   ),
                                 ),
                                Row(
                                  //mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RaisedButton(
                                      color: Theme.of(context).accentColor,
                                      child: Text(
                                        AppLocalizations.of(context).translate('attachImage') ?? "",
                                        style:
                                        TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () => showOptionsDialog(context, model),
                                    ),
                                  ],
                                ),
                              ],
                            )
                            : Row(
                          children: [
                            RaisedButton(
                              color: Theme.of(context).accentColor,
                              child: Text(
                                AppLocalizations.of(context).translate('attachImage') ?? "",
                                style:
                                TextStyle(color: Colors.white),
                              ),
                              onPressed: () => showOptionsDialog(context, model),

                            ),
                          ],
                        ),
                        // Row(
                        //   mainAxisAlignment:
                        //   MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     RaisedButton(
                        //       color: Theme.of(context).accentColor,
                        //       onPressed: () => model.determinePosition(),
                        //       child: Text(
                        //         "Add location",
                        //         style: TextStyle(color: Colors.white),
                        //       ),
                        //     ),
                        //     model.loadingLocation
                        //         ? CircularProgressIndicator()
                        //         : model.location == null
                        //         ? Container()
                        //         : Icon(Icons.done,
                        //         size: 35, color: Colors.green),
                        //   ],
                        // ),
                        SizedBox(
                          height:
                          MediaQuery.of(context).size.height * 0.1,
                        ),
                      ],
                    ),
                  ),
          ),
          floatingActionButton: model.isBusy
              ? null
              : FloatingActionButton.extended(
                  onPressed: () => model.submitRequest(),
                  label: Text(
                      AppLocalizations.of(context).translate('addRequest')),
                  icon: Icon(Icons.done_all),
                ),
        );
      },
    );
  }
}

Future<void> showOptionsDialog(BuildContext context, Step4Model model) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Upload Image"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.camera_fill, color: Theme.of(context).primaryColor),
                      SizedBox(width: 10),
                      Text("Camera"),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    model.uploadCameraImage();
                  },
                ),
                Padding(padding: EdgeInsets.all(10)),
                GestureDetector(
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.photo_fill_on_rectangle_fill, color: Theme.of(context).primaryColor),
                      SizedBox(width: 10),
                      Text("Photo Library"),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    model.uploadGalleryImage();
                  },
                ),
              ],
            ),
          ),
        );
      }
  );
}
