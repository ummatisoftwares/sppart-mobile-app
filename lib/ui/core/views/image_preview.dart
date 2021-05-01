import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageView extends StatefulWidget {
  final String url;

  const ImageView({Key key, this.url}) : super(key: key);

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  BoxFit fit = BoxFit.none;

  chaneFit() {
    if (fit == BoxFit.fill) {
      setState(() {
        fit = BoxFit.none;
      });
    } else {
      setState(() {
        fit = BoxFit.fill;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Container(
        child: InkWell(
            onTap: chaneFit,
            child: PhotoView(
              imageProvider: NetworkImage(widget.url),
            )),
      ),
    );
  }
}
