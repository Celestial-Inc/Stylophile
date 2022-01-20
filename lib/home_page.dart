import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.purple[100],
      body: Center(
          child: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
              height: 40,
              width: 40,
              color: Colors.red.withOpacity(0),
              child: Image.asset('assets/images/welcome.png')),
          const SizedBox(height: 10),
          Container(
              height: 90,
              width: 90,
              color: Colors.red.withOpacity(0),
              child: Image.asset('assets/images/Stylophile.png')),
          const SizedBox(height: 20),
          Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Text(
              'Here at Stylophile you can create the outfits of your dreams and mix and match them as you please.',
              style: TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            child: Text(
              '_________________________________',
              style: TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Text(
              'To get started, press the "Add" section located in the bottom navigation bar.',
              style: TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(child: Icon(Icons.add, color: Colors.white, size: 30)),
          Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Text(
              'Add',
              style: TextStyle(fontSize: 18, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Text(
              'In the wardrobe page, you are able to see all your uploaded images through swiping, in addition to that, you can also share your created outfits to any day on the built in calendar page also accessible on your bottom navigation bar',
              style: TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                child: Icon(
              Icons.checkroom,
              color: Colors.white,
              size: 30,
            )),
            Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Text(
                'Wardrobe',
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Container(
                child: Icon(
              Icons.date_range,
              color: Colors.white,
              size: 30,
            )),
            Container(
              child: Text(
                'Calendar',
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ]),
          const SizedBox(height: 20),
          Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Text(
              'Now of course, while planning your outfits, keeping the weather in mind is an important aspect of the planning, so we built in a weather page, also accessible through your bottom navigation bar',
              style: TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          Container(
              child: Icon(
            Icons.cloud,
            color: Colors.white,
            size: 30,
          )),
          Container(
            child: Text(
              'Weather',
              style: TextStyle(fontSize: 18, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            '_________________________________',
            style: TextStyle(fontSize: 20, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Text(
              'What? You don\'t like any of your clothes? And can\'t use our app? We can help you with that! The three icons below take you to different stores, make sure to come back once you own more clothing items!',
              style: TextStyle(fontSize: 20, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            IconButton(
                icon: Image.asset('assets/images/bershka.png'),
                iconSize: 75,
                color: Colors.red.withOpacity(0),
                onPressed: () {
                  launch('https://www.bershka.com/');
                }),
            IconButton(
                icon: Image.asset('assets/images/hm.png'),
                iconSize: 75,
                color: Colors.red.withOpacity(0),
                onPressed: () {
                  launch('https://www.hm.com/');
                }),
            IconButton(
                icon: Image.asset('assets/images/asos.png'),
                iconSize: 75,
                color: Colors.red.withOpacity(0),
                onPressed: () {
                  launch('https://www.asos.com/');
                }),
          ]),
          const SizedBox(height: 50),
          Container(
              height: 90,
              width: 90,
              color: Colors.red.withOpacity(0),
              child: Image.asset('assets/images/Celestial.png')),
          const SizedBox(
            height: 20,
          ),
        ],
      )),
    ));
  }
}
