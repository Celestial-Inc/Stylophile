import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:virtual_closet/imagedeletion_loadingpage.dart';
import 'package:virtual_closet/loading_screen.dart';
import 'package:hive/hive.dart';
import 'dart:convert';

class WardrobePage extends StatefulWidget {
  @override
  _WardrobePageState createState() => _WardrobePageState();
}

class _WardrobePageState extends State<WardrobePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          return Stack(
            children: [
              buildImageFromAsset(hiveBox, index),
              Positioned(
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
                              hiveBox.deleteAt(
                                  index); //TODO: only works if you switch to a different page after deletion and then come back, -> maybe go to loading page and back, this way means no stateful widget = less work same result?
                              hiveBox.loadHiveImages();
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoadingImageDeletion()),
                              );
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          );
        },
      ),
    ),
  );
}
