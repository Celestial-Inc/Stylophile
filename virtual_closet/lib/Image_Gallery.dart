import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';

class ImageGallery extends StatefulWidget {
  @override
  _ImageGalleryState createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  List<Widget> buildImage(BuildContext context) {
    List<Widget> widgets = [];
    var hiveBox = Hive.box('shirts');
    var length = hiveBox.length;
    for (int x = 0; x < length; x++) {
      var hiveImage = hiveBox.getAt(x);
      //widgets.add(buildImage(hiveImage));
    }
    return widgets;
  }

  late ScrollController _scrollViewController;
  bool _showAppbar = true;
  bool isScrollingDown = false;

  @override
  void initState() {
    super.initState();
    _scrollViewController = new ScrollController();
    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          _showAppbar = false;
          setState(() {});
        }
      }

      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          _showAppbar = true;
          setState(() {});
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _scrollViewController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            AnimatedContainer(
              height: _showAppbar ? 56.0 : 0.0,
              duration: Duration(milliseconds: 200),
              child: AppBar(
                backgroundColor: Color.fromARGB(250, 230, 150, 200),
                centerTitle: true,
                title: Text('Images'),
                actions: <Widget>[
                  //add buttons here
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollViewController,
                child: Column(
                  children: <Widget>[
                    Container(
                        child: Text(
                      'Images will be displayed here, check out Website: https://daily-dev-tips.com/posts/building-a-photo-grid-view-in-flutter/',
                      style: TextStyle(fontSize: 50),
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
