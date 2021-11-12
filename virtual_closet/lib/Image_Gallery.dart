
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';


class ImageGallery extends StatefulWidget {
  @override
  _ImageGalleryState createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  Widget buildImage(BuildContext context) {
    List<Widget> widgets = [];
    var hiveBox = Hive.box('shirts');
    var length = hiveBox.length;
    for (int x = 0; x < length; x++) {
      var hiveImage = hiveBox.getAt(x);
      widgets.add(buildImage(hiveImage));
    return 
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}