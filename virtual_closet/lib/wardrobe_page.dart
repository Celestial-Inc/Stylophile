import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class WardrobePage extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
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
  final imageList = [
    'assets/images/shirt01.jpg',
    'assets/images/shirt02.jpg',
    'assets/images/shirt03.jpg'
  ];

  @override
  Widget build(BuildContext context) => buildCarousel(context, imageList);
}

class PantCarousel extends StatelessWidget {
  final imageList = [
    'assets/images/pants01.jpg',
    'assets/images/pants02.jpeg',
    'assets/images/pants03.jpg'
  ];
  @override
  Widget build(BuildContext context) => buildCarousel(context, imageList);
}

class ShoeCarousel extends StatelessWidget {
  final imageList = [
    'assets/images/shoes01.jpg',
    'assets/images/shoes02.png',
    'assets/images/shoes03.jpg'
  ];
  @override
  Widget build(BuildContext context) => buildCarousel(context, imageList);
}

  Widget buildImageFromAsset(String urlImage1, int index) => Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      color: Colors.pink[200],
      child: Image.asset(
        urlImage1,
        fit: BoxFit.cover,
      ),
    );

Widget buildCarousel(BuildContext context, imageList) => Scaffold(
      backgroundColor: Colors.purple[100],
      body: Center(
        child: CarouselSlider.builder(
          options: CarouselOptions(
              height: 200, enlargeStrategy: CenterPageEnlargeStrategy.height),
          itemCount: imageList.length,
          itemBuilder: (context, index, realIndex) {
            final urlImage1 = imageList[index];

            return buildImageFromAsset(urlImage1, index);
          },
        ),
      ),
    );

