import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.purple[100],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(child: Carousel1(), height: 200),
            Container(child: Carousel2(), height: 200),
            Container(child: Carousel3(), height: 200)
          ],
          /* child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Card(
                child: Image.asset(
                  'assets/tshirt.jpg',
                  height: 150,
                ),
              ),
              Card(
                child: Image.asset(
                  'assets/pants.jpg',
                  height: 150,
                ),
              ),
              Card(
                child: Image.asset(
                  'assets/shoes.jpg',
                  height: 150,
                ),
              )
            ],
          ), */
        ),
      ),
    );
  }
}

class Carousel1 extends StatelessWidget {
  final urlImages1 = [
    'assets/images/shirt01.jpg',
    'assets/images/shirt02.jpg',
    'assets/images/shirt03.jpg'
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.purple[100],
        body: Center(
          child: CarouselSlider.builder(
            options: CarouselOptions(
                height: 200, enlargeStrategy: CenterPageEnlargeStrategy.height),
            itemCount: urlImages1.length,
            itemBuilder: (context, index, realIndex) {
              final urlImage1 = urlImages1[index];

              return buildImage(urlImage1, index);
            },
          ),
        ),
      );
  Widget buildImage(String urlImage1, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        color: Colors.pink[200],
        child: Image.asset(
          urlImage1,
          fit: BoxFit.cover,
        ),
      );
}

class Carousel2 extends StatelessWidget {
  final urlImages2 = [
    'assets/images/pants01.jpg',
    'assets/images/pants02.jpeg',
    'assets/images/pants03.jpg'
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.purple[100],
        body: Center(
          child: CarouselSlider.builder(
            options: CarouselOptions(
                height: 200, enlargeStrategy: CenterPageEnlargeStrategy.height),
            itemCount: urlImages2.length,
            itemBuilder: (context, index, realIndex) {
              final urlImage2 = urlImages2[index];

              return buildImage(urlImage2, index);
            },
          ),
        ),
      );
  Widget buildImage(String urlImage2, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        color: Colors.pink[200],
        child: Image.asset(
          urlImage2,
          fit: BoxFit.cover,
        ),
      );
}

class Carousel3 extends StatelessWidget {
  final urlImages3 = [
    'assets/images/shoes01.jpg',
    'assets/images/shoes02.png',
    'assets/images/shoes03.jpg'
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.purple[100],
        body: Center(
          child: CarouselSlider.builder(
            options: CarouselOptions(
                height: 200, enlargeStrategy: CenterPageEnlargeStrategy.height),
            itemCount: urlImages3.length,
            itemBuilder: (context, index, realIndex) {
              final urlImage3 = urlImages3[index];

              return buildImage(urlImage3, index);
            },
          ),
        ),
      );
  Widget buildImage(String urlImage3, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        color: Colors.pink[200],
        child: Image.asset(
          urlImage3,
          fit: BoxFit.cover,
        ),
      );
}
