import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hive/hive.dart';
import 'dart:convert';

class WardrobePage extends StatefulWidget {
  @override
  _WardrobePageState createState() => _WardrobePageState();
}

class _WardrobePageState extends State<WardrobePage> {
  bool _forceRefresh = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.purple[100],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(child: buildCarousel(context, 'shirts'), height: 200),
          Container(child: buildCarousel(context, 'bottoms'), height: 200),
          Container(child: buildCarousel(context, 'shoes'), height: 200)
        ],
      ),
    );
  }

  Widget buildDeleteButton(Box hiveBox, int index) {
    return Positioned(
        height: 20,
        width: 20,
        right: 0.0,
        top: 0.0,
        child: FloatingActionButton(
          child: const Icon(
            Icons.close_outlined,
            size: 10,
          ),
          backgroundColor: Colors.purple[600],
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Warning!'),
              content: const Text('Do you wish to delete this Image?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => {Navigator.pop(context, 'No')},
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'Yes');
                    hiveBox.deleteAt(index);
                    setState(() {
                      // set forceRefresh to the opposite of whatever it is. It just flips between true and false.
                      _forceRefresh = !_forceRefresh;
                    });
                  },
                  child: const Text('Yes'),
                ),
              ],
            ),
          ),
        ));
  }

  Widget buildImageFromAsset(Box hiveBox, int index) {
    String imageAsString = hiveBox.getAt(index);
    var container = Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      color: Colors.pink[200],
      child: Image.memory(base64Decode(imageAsString), fit: BoxFit.cover),
    );
    return container;
  }

  Widget buildCarousel(BuildContext context, String boxName) {
    // boxName is either 'shirts', 'bottoms', or 'shoes'
    Box hiveBox = Hive.box(boxName);

    var itemCount = hiveBox.length;

    // if there are no items then just display a nice text message
    if (itemCount == 0) {
      return Text('Press Add to add ' + hiveBox.name.toString(),
          style: TextStyle(fontSize: 40));
    }

    return Scaffold(
      backgroundColor: Colors.purple[100],
      body: Center(
        child: CarouselSlider.builder(
          options: CarouselOptions(
              height: 200, enlargeStrategy: CenterPageEnlargeStrategy.height),
          itemCount: itemCount,
          itemBuilder: (context, index, realIndex) {
            return Stack(
              children: [
                buildImageFromAsset(hiveBox, index),
                buildDeleteButton(hiveBox, index),
              ],
            );
          },
        ),
      ),
    );
  }
}
