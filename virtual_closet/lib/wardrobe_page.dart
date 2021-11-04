import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class WardrobePage extends StatelessWidget {
  const WardrobePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(child: ShirtCarousel(), height: 200),
          SizedBox(child: PantCarousel(), height: 200),
          SizedBox(child: ShoeCarousel(), height: 200)
        ],
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class ShirtCarousel extends StatelessWidget {
  final imageList = [
    'assets/images/shirt01.jpg',
    'assets/images/shirt02.jpg',
    'assets/images/shirt03.jpg'
  ];

  @override
  Widget build(BuildContext context) => buildCarousel(context, imageList);
}

// ignore: use_key_in_widget_constructors
class PantCarousel extends StatelessWidget {
  final imageList = [
    'assets/images/pants01.jpg',
    'assets/images/pants02.jpeg',
    'assets/images/pants03.jpg'
  ];
  @override
  Widget build(BuildContext context) => buildCarousel(context, imageList);
}

// ignore: use_key_in_widget_constructors
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
      margin: const EdgeInsets.symmetric(horizontal: 8),
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
