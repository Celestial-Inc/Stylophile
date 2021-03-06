import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Stylophile/utils.dart';
import 'package:Stylophile/weather_loader.dart';
import 'package:Stylophile/home_page.dart';
import 'package:Stylophile/add_clothes_page.dart';
import 'package:Stylophile/calendar_page.dart';
import 'package:Stylophile/wardrobe_page.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  initializeHive()
      .then((_) => initializeDateFormatting().then((_) => runApp(MyApp())));
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarColor: Colors.purpleAccent,
        systemNavigationBarColor: Colors.purpleAccent),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stylophile',
      home: PageFrame(),
    );
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
