import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:virtual_closet/utils.dart';
import 'package:virtual_closet/weather_page.dart';
import 'package:virtual_closet/home_page.dart';
import 'package:virtual_closet/add_clothes_page.dart';
import 'package:virtual_closet/calendar_page.dart';
import 'package:virtual_closet/wardrobe_page.dart';
import 'add_images_page.dart';
import 'package:hive/hive.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  initializeHive().then((_) => initializeDateFormatting().then((_) => runApp(MyApp())));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  final List _screens = [HomePage(), WardrobePage(), AddClothesPage(), CalendarPage(), WeatherPage()];

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
