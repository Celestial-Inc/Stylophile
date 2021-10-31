import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

main() => runApp(MyApp());

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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stylophile',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _currentIndex = 0; // default selected navbar item is "Home"

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.purple[100],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(child: ShirtCarousel(), height: 200),
            Container(child: PantCarousel(), height: 200),
            Container(child: ShoeCarousel(), height: 200)
          ],
        ), 
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF6200EE),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.60),
        currentIndex: _currentIndex,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        onTap: (value) {
          // Respond to item press.
          setState(() => _currentIndex = value);
        },
        items: const [
          BottomNavigationBarItem(
            title: Text('Home'),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text('Wardrobe'),
            icon: Icon(Icons.checkroom),
          ),
          BottomNavigationBarItem(
            title: Text('Add'),
            icon: Icon(Icons.add),
          ),
          BottomNavigationBarItem(
            title: Text('Calendar'),
            icon: Icon(Icons.date_range),
          ),
          BottomNavigationBarItem(
            title: Text('Weather'),
            icon: Icon(Icons.cloud),
          ),
        ],
      ),
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
