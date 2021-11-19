import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:virtual_closet/utils.dart';
import 'package:virtual_closet/weather_loader.dart';
import 'package:virtual_closet/home_page.dart';
import 'package:virtual_closet/add_clothes_page.dart';
import 'package:virtual_closet/calendar_page.dart';
import 'package:virtual_closet/wardrobe_page.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  initializeHive()
      .then((_) => initializeDateFormatting().then((_) => runApp(MyApp())));
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarColor: Colors.purpleAccent,
        systemNavigationBarColor: Colors.purpleAccent),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stylophile',
      home: PageFrame(),
    );
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 5,
        navigateAfterSeconds: new HomePage(),
        title:
            new Text('Stylophile', style: GoogleFonts.lobster(fontSize: 20.0)),
        image: Image.asset('assets/images/icon.png'),
        gradientBackground: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xb71e98), Color(0x771ac5)]),
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        loaderColor: Colors.pink[800]);
  }
}

class PageFrame extends StatefulWidget {
  @override
  _PageFrameState createState() => _PageFrameState();
}

class _PageFrameState extends State<PageFrame> {
  int _currentIndex = 0; // default selected navbar item is "Home"
  List _screens = [
    HomePage(),
    WardrobePage(),
    AddClothesPage(),
    CalendarPage(),
    WeatherLoaderPage()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xFFDC67F7),
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
