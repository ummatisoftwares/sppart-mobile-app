import 'package:flutter/material.dart';

import 'package:spraat/model/offer.dart';

class BuyItem extends StatelessWidget {
  final Offer offer;

  const BuyItem({Key key, this.offer}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          offer.detailsView(context),
          Text(
            "Payment Method:",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(
            "Cash",
            style: TextStyle(fontSize: 22),
          )
        ])),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {}),
    );
  }
}
