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
      this.selectedItem,
      })
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
              title: Text(AppLocalizations.of(context).translate('addRequest') ?? ""),
              //leading: IconButton( onPressed: ()=> model.moveToStep3() , icon: Icon(Icons.arrow_back, color: Colors.white,)),
          ),
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
                        SizedBox(height: 5),
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
                        SizedBox(height: 5),
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
                        SizedBox(height: 5),
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
                        SizedBox(height: 5),
                        Card(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    child: Text(
                                      AppLocalizations.of(context)
                                              .translate('category') ??
                                          "",
                                      style: TextStyle(
                                          fontSize: 18,color: Colors.grey[400], fontWeight: FontWeight.w600),
                                    )),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.475,
                                  child: Text(selectedCategory.name,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
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
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.475,
                                  child: Text(selectedItem.name,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        SizedBox(height: 5),
                        Card(
                          child: Column(
                            children: [
                              SizedBox(height: 4),
                              Container(
                                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                                child: TextFormField(
                                    controller: model.noteEditingController,
                                    minLines: 1,
                                    maxLines: 5,
                                    decoration: InputDecoration(
                                        hintText: AppLocalizations.of(context).translate('describeYourItem'),
                                        icon: Icon(Icons.description, color: Theme.of(context).primaryColor))
                                ),
                              ),
                              SizedBox(height: 12),

                              Padding(
                                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                                child: model.images.isNotEmpty ? Column(
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
                                                width: 142,
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
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        RaisedButton.icon(
                                          color: Theme.of(context).accentColor,
                                          icon: Icon(Icons.add_a_photo, color: Colors.white),
                                          label: Text(
                                            AppLocalizations.of(context).translate('uploadImage') ?? "",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () => showOptionsDialog(context, model, false),
                                        ),
                                      ],
                                    ),
                                  ],
                                ) : Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                child: Text( AppLocalizations.of(context).translate('uploadItemImage') ?? "", style: TextStyle(color: Colors.blueGrey[400], fontSize: 12, fontWeight: FontWeight.w500))
                                            ),
                                            RaisedButton.icon(
                                              color: Theme.of(context).accentColor,
                                              icon: Icon(Icons.add_a_photo, color: Colors.white),
                                              label: Text(
                                                AppLocalizations.of(context).translate('uploadImage') ?? "",
                                                style: TextStyle(color: Colors.white),
                                              ),
                                              onPressed: () => showOptionsDialog(context, model, false),
                                            ),
                                          ],
                                        ),
                                    // Expanded(
                                    //   flex: 4,
                                    //   child: Text( AppLocalizations.of(context).translate('uploadItemImage') ?? "", style: TextStyle(color: Colors.blueGrey, fontSize: 14, fontWeight: FontWeight.w500))
                                    // ),
                                    // Expanded(
                                    //   flex: 1,
                                    //   child:  RaisedButton(
                                    //     color: Theme.of(context).accentColor,
                                    //     child: Icon(Icons.add_a_photo, color: Colors.white),
                                    //     onPressed: () => showOptionsDialog(context, model, false),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 8),
                            ],
                          ),
                        ),
                        Card(
                          child: Column(
                            children: [
                              SizedBox(height: 12),
                              // Form(
                              //   key: model.chassisKey,
                              //     child: Container(
                              //       padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                              //       child: TextFormField(
                              //         controller: model.chassisEditingController,
                              //         minLines: 1,
                              //         decoration: InputDecoration(
                              //             hintText: AppLocalizations.of(context).translate('chassisNumber') ?? "",
                              //             icon: Icon(Icons.airport_shuttle, color: Theme.of(context).primaryColor)),
                              //         validator: (value) {
                              //           if (value.isEmpty && model.chassisNum == null) {
                              //             return AppLocalizations.of(context).translate('chassisNumberRequired') ?? "";
                              //           } else if (value.length != 17 && model.chassisNum == null) {
                              //             return AppLocalizations.of(context).translate('chassisNumberMustBe') ?? "";
                              //           }
                              //           return null;
                              //         },
                              //       ),
                              //     ),
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     Container(margin: EdgeInsets.fromLTRB(12, 22, 24, 14),height: 1.5, width: 120, color: Colors.blueGrey[300],),
                              //     Padding(padding: const EdgeInsets.fromLTRB(0, 8, 0, 0), child: Text(AppLocalizations.of(context).translate('or') ?? "", style: TextStyle(fontSize: 16 ,color: Colors.blueGrey[300])),),
                              //     Container(margin: EdgeInsets.fromLTRB(24, 22, 12, 14),height: 1.5, width: 120, color: Colors.blueGrey[300],),
                              //   ],
                              // ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                                child: model.chassisNum != null ?
                                Container(
                                          margin: EdgeInsets.symmetric(vertical: 6),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  height: 80,
                                                  width: 142,
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                      image: DecorationImage(
                                                          image: NetworkImage(model.chassisNum,),
                                                          fit: BoxFit.contain))),
                                              InkWell(
                                                onTap: () => model.deleteChassisImage(),
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
                                        )
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.start,
                                    //   children: [
                                    //     RaisedButton.icon(
                                    //       color: Theme.of(context).accentColor,
                                    //       icon: Icon(Icons.add_a_photo, color: Colors.white),
                                    //       label: Text(
                                    //         AppLocalizations.of(context).translate('uploadImage') ?? "",
                                    //         style: TextStyle(color: Colors.white),
                                    //       ),
                                    //       onPressed: () => showOptionsDialog(context, model, true),
                                    //     ),
                                    //   ],
                                    // ),
                                  : Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                        Container(
                                            //width: MediaQuery.of(context).size.width*0.4,
                                            child: Text( AppLocalizations.of(context).translate('addBackSideImage') ?? "", style: TextStyle(color: Colors.blueGrey[400], fontSize: 12, fontWeight: FontWeight.w500))
                                        ),
                                        RaisedButton.icon(
                                          color: Theme.of(context).accentColor,
                                          icon: Icon(Icons.add_a_photo, color: Colors.white),
                                          label: Text(
                                            AppLocalizations.of(context).translate('uploadImage') ?? "",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () => showOptionsDialog(context, model, true),
                                        ),
                                      ],
                                    ),
                                    //   Expanded(
                                    //       flex: 4,
                                    //       child: Text( AppLocalizations.of(context).translate('addBackSideImage') ?? "", style: TextStyle(color: Colors.blueGrey, fontSize: 14, fontWeight: FontWeight.w500))
                                    //   ),
                                    //   SizedBox(width: 12),
                                    //   Expanded(
                                    //     flex: 1,
                                    //     child:  IconButton(
                                    //       color: Theme.of(context).accentColor,
                                    //       icon: Icon(Icons.add_a_photo, color: Theme.of(context).primaryColor),
                                    //       iconSize: 28,
                                    //       onPressed: () => showOptionsDialog(context, model, true),
                                    //     ),
                                    //   ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        Card(
                          child: Form(
                            key: model.formKey,
                            child: Column(
                              children: [
                                SizedBox(height: 4),
                                Container(
                                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                                  child: TextFormField(
                                      controller: model.phoneEditingController,
                                      minLines: 1,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return AppLocalizations.of(context).translate("phoneNumberRequired") ?? "";
                                        } else if (value.length != 8) {
                                          return AppLocalizations.of(context).translate("phoneNumberMustBe") ?? "";
                                        }
                                        return null;
                                      },
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ], // Only numbers can be entered
                                      decoration: InputDecoration(
                                          hintText: AppLocalizations.of(context).translate("phoneNumber") ?? "",
                                          icon: Icon(Icons.phone, color: Theme.of(context).primaryColor))),
                                ),
                                SizedBox(height: 16),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: MediaQuery.of(context).size.height * 0.08,),
                      ],
                    ),
                  ),
          ),
          floatingActionButton: model.isBusy
              ? null
              : FloatingActionButton.extended(
                  onPressed: () => model.submitRequest(context),
                  //onPressed: () => model.SubmitRequest(),
                  label: Text(
                      AppLocalizations.of(context).translate('submitRequest')),
                  icon: Icon(Icons.done_all),
                ),
        );
      },
    );
  }
}

Future<void> showOptionsDialog(BuildContext context, Step4Model model, bool isChassis) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context).translate('uploadImage') ?? ""),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.camera_fill, color: Theme.of(context).primaryColor),
                      SizedBox(width: 10),
                      Text(AppLocalizations.of(context).translate('camera') ?? ""),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    isChassis? model.uploadCameraChassisImage() : model.uploadCameraImage();
                  },
                ),
                Padding(padding: EdgeInsets.all(10)),
                GestureDetector(
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.photo_fill_on_rectangle_fill, color: Theme.of(context).primaryColor),
                      SizedBox(width: 10),
                      Text(AppLocalizations.of(context).translate('photoLibrary') ?? ""),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    isChassis? model.uploadGalleryChassisImage() : model.uploadGalleryImage();
                  },
                ),
              ],
            ),
          ),
        );
      }
  );
}
