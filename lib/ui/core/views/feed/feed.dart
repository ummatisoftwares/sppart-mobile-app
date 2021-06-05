import 'dart:io';

import 'package:flutter/material.dart';
import 'package:spraat/model/offer.dart';
import 'package:spraat/services/app_localization.dart';
import 'model.dart';
import 'package:stacked/stacked.dart';

class FeedView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FeedModel>.reactive(
      onModelReady: (model) => model.init(),
      viewModelBuilder: () => FeedModel(),
      builder: (context, model, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context).translate('feed')),
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () => model.addRequest(),
              label: Text(AppLocalizations.of(context).translate('addRequest')),
              icon: Icon(Icons.add),
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
                : model.requests.length == 0
                    ? Center(
                        child: Text("No Pending Requests"),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          return await model.init();
                        },
                      child: Container(
                          //margin: EdgeInsets.only(top: 8),
                          child: ListView.builder(
                            itemCount: model.requests.length,
                            itemBuilder: (context, index) {
                              return CardView(model: model, index: index);
                            },
                          ),
                        ),
                    ));
      },
    );
  }
}

class CardView extends StatelessWidget {
  final FeedModel model;
  final int index;

  const CardView( {
    Key key,
    this.model,
    this.index
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => model.previewRequest(model.requests[index]),
      child: Container(
        margin: index ==0 ? EdgeInsets.only(top: 8): EdgeInsets.all(0),
        padding: const EdgeInsets.all(12.0),
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: ClipPath(
            clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
            child: Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    //color: Color.fromRGBO(0, 81, 113, .1),
                    border: Border(bottom: BorderSide(color: getColor(model.requests[index].status), width: 7)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 8),
                        SizedBox(height: 100, width: 100,child: Center(child: Image.network( model.getBrand(model.requests[index].carBrand).imageURL, height: 80, width: 80))),
                        SizedBox(width: 8),
                        Column(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children:[ Icon(Icons.settings, color: Theme.of(context).primaryColor), SizedBox(width: 8), Text(model.requests[index].itemName, style: TextStyle(color: Colors.black87))]),
                            Row(children:[ Icon(Icons.time_to_leave, color: Theme.of(context).primaryColor), SizedBox(width: 8), Text(model.requests[index].carName, style: TextStyle(color: Colors.black87))]),
                            Row(children:[ Icon(Icons.av_timer, color: Theme.of(context).primaryColor), SizedBox(width: 8), Text(model.requests[index].carModel, style: TextStyle(color: Colors.black87))]),
                          ],
                        ),
                        Spacer(),
                        model.requests[index].isShow == "true" && int.parse(model.requests[index].offerNum) > 0?
                        Container(
                          margin: EdgeInsets.only(top: 24),
                          height: 22,
                          width: 22,
                          decoration: BoxDecoration(
                            color: Colors.red, //getColor(model.requests[index].status),
                            shape: BoxShape.circle
                          ),
                          child: Center(child: Text(model.requests[index].offerNum, style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),))
                        )
                        : Container(),
                        SizedBox(width: 8),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          Row(children: [
                            Icon(Icons.settings_backup_restore, color: Theme.of(context).primaryColor),
                            Text(model.requests[index].time.toDate().toString().substring(0, 10), style: TextStyle(color: Colors.black87)),],),
                          Text(model.requests[index].status, style: TextStyle(color: getColor(model.requests[index].status), fontSize: 15, fontWeight: FontWeight.w500))
                        ]
                      ),
                    ),
                  ],
                )
              ),
            ),
        ),
        ),
    );
  }
}

Color getColor(String status){
  if(status == "Processing")
    return Colors.amber;
  if(status == "Available")
    return Colors.green;
    //return Color.fromRGBO(0, 81, 113, 1.0);
  if(status == "Completed")
    return Color.fromRGBO(0, 81, 113, 1.0);
    //return Colors.green;
  if(status == "Canceled")
    return Colors.red;
}
