import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:virtual_closet/utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hive/hive.dart';
import 'dart:convert';

Future<void> main() async {
  initializeHive().then((_) => initializeDateFormatting().then((_) => runApp(MyApp())));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stylophile',
      home: WardrobePage(),
    );
  }
}

class WardrobePage extends StatefulWidget {
  @override
  _WardrobePageState createState() => _WardrobePageState();
}

class _WardrobePageState extends State<WardrobePage> {
  bool _imageAreLoaded = false;

  void loadHiveImages() async {
    Box shirtsBox = Hive.box('shirts');
    if (shirtsBox.isEmpty) {
      shirtsBox.put('shirt1', await convertImageToString('assets/images/shirt01.jpg'));
      shirtsBox.put('shirt2', await convertImageToString('assets/images/shirt02.jpg'));
      shirtsBox.put('shirt3', await convertImageToString('assets/images/shirt03.jpg'));
    }

    setState(() {
      _imageAreLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    loadHiveImages();
  }

  @override
  Widget build(BuildContext context) {
    if (_imageAreLoaded == false) {
      return Scaffold(body: Center(child: Text('Loading...')));
    }

    return Scaffold(
      backgroundColor: Colors.purple[100],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(child: ShirtCarousel(), height: 200),
        ],
      ),
    );
  }
}

class ShirtCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Box shirtsBox = Hive.box('shirts');
    return buildCarousel(context, shirtsBox);
  }
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

Widget buildCarousel(BuildContext context, hiveBox) {
  var itemCount = hiveBox.length;
  return Scaffold(
    backgroundColor: Colors.purple[100],
    body: Center(
      child: CarouselSlider.builder(
        options: CarouselOptions(height: 200, enlargeStrategy: CenterPageEnlargeStrategy.height),
        itemCount: itemCount,
        itemBuilder: (context, index, realIndex) {
          return buildImageFromAsset(hiveBox, index);
        },
      ),
    ),
  );
}
