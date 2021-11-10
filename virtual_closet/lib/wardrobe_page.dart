import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hive/hive.dart';
import 'dart:convert';

class WardrobePage extends StatefulWidget {
  @override
  _WardrobePageState createState() => _WardrobePageState();
}

class _WardrobePageState extends State<WardrobePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.purple[100],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(child: ShirtCarousel(), height: 200),
          Container(child: PantCarousel(), height: 200),
          Container(child: ShoeCarousel(), height: 200)
        ],
      ),
    );
  }
}

class ShirtCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Box box = Hive.box('shirts');
    return buildCarousel(context, box);
  }
}

class PantCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Box box = Hive.box('bottoms');
    return buildCarousel(context, box);
  }
}

class ShoeCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Box box = Hive.box('shoes');
    return buildCarousel(context, box);
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
