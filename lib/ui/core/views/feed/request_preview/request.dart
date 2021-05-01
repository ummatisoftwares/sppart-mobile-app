import 'package:flutter/material.dart';

import 'package:spraat/model/request.dart';

import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../image_preview.dart';
import 'model.dart';

class RequestPreview extends StatelessWidget {
  final Request selectedRequest;

  const RequestPreview({Key key, this.selectedRequest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RequestPreviewModel>.reactive(
      onModelReady: (model) => model.init(selectedRequest),
      viewModelBuilder: () => RequestPreviewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(title: Text("Reqest Details")),
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
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                    "Car Brand:",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                Text(model.selectedBrand.name,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
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
                                    "Car Type:",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                Text(model.selectedtype.name,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
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
                                    "Year Of Make:",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                Text(model.selectedYear.name,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
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
                                    "Engine:",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                Text(model.selectedEngine.name,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
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
                                    "Category:",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                Text(model.selectedCategory.name,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
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
                                    "Item",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                Text(model.selectedItem.name,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
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
                                    "Phone number",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                Text(model.selectedRequest.phoneNumber,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                    "Note",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                Container(
                                  child: Text(model.selectedRequest.note,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
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
                                              fontSize: 18,
                                              fontWeight: FontWeight.w300),
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
                                    "Status",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                Text(model.selectedRequest.status,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
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
                            )
                            : Container(),
                        model.offers.length > 0
                            ? Text("Available offers (${model.offers.length})")
                            : Container(),
                        Column(
                          children: model.offers
                              .map((e) => ListTile(
                                    onTap: () => model.addToCart(e),
                                    leading: e.imageURL == null
                                        ? Container(
                                            height: 50,
                                            width: 50,
                                            child: Center(
                                              child: Icon(Icons.image),
                                            ),
                                          )
                                        : Container(
                                            height: 50,
                                            width: 50,
                                            child: Image.network(e.imageURL)),
                                    title: Text(e.name),
                                    subtitle: Text(e.brand),
                                    trailing: Text(e.price + "BHD"),
                                  ))
                              .toList(),
                        )
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
