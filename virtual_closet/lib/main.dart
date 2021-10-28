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
            Container(
              child: Carousel1(),
              height: 250,
            ),
            Container(child: Carousel2(), height: 250)
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
    'https://dddlzd5g3wzri.cloudfront.net/media/cache/a2/38/images/products/2018/12/Anina-Crop-Top-Kurzarm-black-1_a238569b85865d16aaae149a0d3edbb7.jpg',
    'https://lp2.hm.com/hmgoepprod?set=quality%5B79%5D%2Csource%5B%2F1b%2Fc9%2F1bc925c6b468db60dc7ead77537e53ef5f3b8c77.jpg%5D%2Corigin%5Bdam%5D%2Ccategory%5Bladies_hoodiesswetshirts_hoodies%5D%2Ctype%5BDESCRIPTIVESTILLLIFE%5D%2Cres%5Bm%5D%2Chmver%5B2%5D&call=url[file:/product/main]',
    'https://m.media-amazon.com/images/I/61aueZalO+L._AC_UL320_.jpg'
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.purple[100],
        body: Center(
          child: CarouselSlider.builder(
            options: CarouselOptions(height: 200),
            itemCount: urlImages1.length,
            itemBuilder: (context, index, realIndex) {
              final urlImage1 = urlImages1[index];

              return buildImage(urlImage1, index);
            },
          ),
        ),
      );
  Widget buildImage(String urlImage1, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        color: Colors.pink[200],
        child: Image.network(
          urlImage1,
          fit: BoxFit.cover,
        ),
      );
}

class Carousel2 extends StatelessWidget {
  final urlImages2 = [
    'https://lp2.hm.com/hmgoepprod?set=quality%5B79%5D%2Csource%5B%2F51%2Fd7%2F51d76619edcaa25f5179b0e2119e5a85b6b397de.jpg%5D%2Corigin%5Bdam%5D%2Ccategory%5Bladies_trousers_flare%5D%2Ctype%5BDESCRIPTIVESTILLLIFE%5D%2Cres%5Bm%5D%2Chmver%5B1%5D&call=url[file:/product/main]',
    'https://agnesb-agnesb-com-storage.omn.proximis.com/Imagestorage/imagesSynchro/0/0/cc48a463b58fc982d72d65925a294ae1b4472ea3_O689U700_001_1.jpeg',
    'https://cms.brnstc.de/product_images/435x596/20/06/100102726017000_0.jpg'
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.purple[100],
        body: Center(
          child: CarouselSlider.builder(
            options: CarouselOptions(height: 200),
            itemCount: urlImages2.length,
            itemBuilder: (context, index, realIndex) {
              final urlImage2 = urlImages2[index];

              return buildImage(urlImage2, index);
            },
          ),
        ),
      );
  Widget buildImage(String urlImage2, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        color: Colors.pink[200],
        child: Image.network(
          urlImage2,
          fit: BoxFit.cover,
        ),
      );
}
