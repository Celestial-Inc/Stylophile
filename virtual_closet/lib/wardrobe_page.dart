import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:virtual_closet/utils.dart';
import 'package:hive/hive.dart';
import 'dart:convert';

class WardrobePage extends StatefulWidget {
  const WardrobePage({Key? key}) : super(key: key);

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

    Box bottomsBox = Hive.box('bottoms');
    if (bottomsBox.isEmpty) {
      bottomsBox.put('bottoms1', await convertImageToString('assets/images/pants01.jpg'));
      bottomsBox.put('bottoms2', await convertImageToString('assets/images/pants02.jpeg'));
      bottomsBox.put('bottoms3', await convertImageToString('assets/images/pants03.jpg'));
    }

    Box shoesBox = Hive.box('shoes');
    if (shoesBox.isEmpty) {
      shoesBox.put('shoes1', await convertImageToString('assets/images/shoes01.jpg'));
      shoesBox.put('shoes2', await convertImageToString('assets/images/shoes02.png'));
      shoesBox.put('shoes3', await convertImageToString('assets/images/shoes03.jpg'));
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
      return const Scaffold(body: Center(child: Text('Loading...')));
    }

    return Scaffold(
      backgroundColor: Colors.purple[100],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          SizedBox(child: ShirtCarousel(), height: 200),
          SizedBox(child: PantCarousel(), height: 200),
          SizedBox(child: ShoeCarousel(), height: 200)
        ],
      ),
    );
  }
}

class ShirtCarousel extends StatelessWidget {
  const ShirtCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Box box = Hive.box('shirts');
    return buildCarousel(context, box);
  }
}

class PantCarousel extends StatelessWidget {
  const PantCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Box box = Hive.box('bottoms');
    return buildCarousel(context, box);
  }
}

class ShoeCarousel extends StatelessWidget {
  const ShoeCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Box box = Hive.box('shoes');
    return buildCarousel(context, box);
  }
}

Widget buildImageFromAsset(Box hiveBox, int index) {
  String imageAsString = hiveBox.getAt(index);
  var container = Container(
    margin: const EdgeInsets.symmetric(horizontal: 8),
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