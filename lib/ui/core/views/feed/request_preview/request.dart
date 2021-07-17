import 'package:flutter/material.dart';
import 'package:spraat/model/request.dart';
import 'package:spraat/services/app_localization.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../image_preview.dart';
import 'model.dart';

class RequestPreview extends StatelessWidget {
  final String selectedRequestID;

  const RequestPreview({Key key, this.selectedRequestID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RequestPreviewModel>.reactive(
      onModelReady: (model) => model.init(selectedRequestID),
      viewModelBuilder: () => RequestPreviewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
              title: Text(AppLocalizations.of(context).translate('requestDetails') ?? ""),
            actions: [
              IconButton(icon: Icon(Icons.delete), onPressed:()=> model.deleteRequest(context))
            ],
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
                        SizedBox(height: 4),
                        model.offers.length > 0
                            ? Text(AppLocalizations.of(context).translate('availableOffers') ?? "", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Theme.of(context).primaryColor),)
                            : Container(),
                        model.offers.length > 0 ? SizedBox(height: 8) : Container(),
                        Column(
                          children: model.offers
                              .map((e) => Card(
                                child: ListTile(
                            onTap: () => model.addToCart(e),
                            dense: true,
                            contentPadding: EdgeInsets.only(left: 16.0, right: 6.0),
                            title: Text(e.name, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
                            subtitle: Text(e.brand),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(e.price + " BHD", style: TextStyle(fontWeight: FontWeight.w600,)),
                                Icon(Icons.navigate_next, color: Theme.of(context).primaryColor)
                              ],
                            ),
                          ),
                              )
                          ).toList(),
                        ),
                        model.offers.length > 0 ? SizedBox(height: 10) : Container(),
                        Text(AppLocalizations.of(context).translate('requestDetails') ?? "", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Theme.of(context).primaryColor)),
                        SizedBox(height: 8),
                        Card(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                    AppLocalizations.of(context).translate('brand') ?? "",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.grey[400], fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Text(model.selectedBrand.name,
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
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                    AppLocalizations.of(context).translate('carType') ?? "",
                                    style: TextStyle(
                                        fontSize: 18,color: Colors.grey[400], fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Text(model.selectedtype.name,
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
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                    AppLocalizations.of(context).translate('yearOfMake') ?? "",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.grey[400], fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Text(model.selectedYear.name,
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
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                      AppLocalizations.of(context).translate('engineSize') ?? "",
                                    style: TextStyle(
                                        fontSize: 18,color: Colors.grey[400], fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Text(model.selectedEngine.name,
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
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                      AppLocalizations.of(context).translate('category') ?? "",
                                    style: TextStyle(
                                        fontSize: 18,color: Colors.grey[400], fontWeight: FontWeight.w600 ),
                                  ),
                                ),
                                Text(model.selectedCategory.name,
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
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                    AppLocalizations.of(context).translate('item') ?? "",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.grey[400], fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.470,
                                  child: Text(model.selectedItem.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                            height: 5
                        ),
                        Card(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width:
                                  MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                    AppLocalizations.of(context).translate('chassisNumber') ?? "",
                                    style: TextStyle(
                                        fontSize: 18,color: Colors.grey[400], fontWeight: FontWeight.w600 ),
                                  ),
                                ),
                                model.selectedRequest.chassisNum.length == 17 ? Text(model.selectedRequest.chassisNum, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)) :
                                GestureDetector(
                                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ImageView(url: model.selectedRequest.chassisNum))),
                                    child: Icon(Icons.image, color: Theme.of(context).primaryColor,)
                                ),
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
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                    AppLocalizations.of(context).translate('phoneNumber') ?? "",
                                    style: TextStyle(fontSize: 18, color: Colors.grey[400], fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Text(model.selectedRequest.phoneNumber,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        ),
                        model.selectedRequest.note == '' ? Container() : SizedBox(height: 5),
                        model.selectedRequest.note == '' ? Container() :
                        Card(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                    AppLocalizations.of(context).translate('desciption') ?? "",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.grey[400], fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.470,
                                  child: Text(model.selectedRequest.note, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        model.selectedRequest.locationURL == null? Container() : SizedBox(height: 5),
                        model.selectedRequest.locationURL == null
                            ? Container()
                            : Card(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  width: double.infinity,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: Text(
                                          "Location",
                                          style: TextStyle(
                                              fontSize: 18, color: Colors.grey[400], fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      IconButton(
                                          icon: Icon(Icons.location_on),
                                          onPressed: () {
                                            launch(model
                                                .selectedRequest.locationURL);
                                          }),
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
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                    AppLocalizations.of(context).translate('status') ?? "",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.grey[400], fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Text(model.selectedRequest.status,
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
                        model.selectedRequest.imageURL != ""
                            ? ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: model.getImageLength(),
                              itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => ImageView(
                                            url: model.getImage(index))));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            height: 80,
                                            width: 160,
                                            decoration: BoxDecoration(
                                                color:
                                                    Colors.grey.withOpacity(0.4),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                      model.getImage(index),
                                                    ),
                                                    fit: BoxFit.contain))),
                                        Icon(
                                          Icons.chevron_right,
                                          size: 30,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ) : Container(),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
