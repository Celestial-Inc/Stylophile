// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:virtual_closet/utils.dart';
import 'package:virtual_closet/weather_page.dart';
import 'package:virtual_closet/home_page.dart';
import 'package:virtual_closet/add_clothes_page.dart';
import 'package:virtual_closet/calendar_page.dart';
import 'package:virtual_closet/wardrobe_page.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  initializeHive().then(
      (_) => initializeDateFormatting().then((_) => runApp(const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Stylophile',
      home: PageFrame(),
    );
  }
}

class PageFrame extends StatefulWidget {
  const PageFrame({Key? key}) : super(key: key);

  @override
  _PageFrameState createState() => _PageFrameState();
}

class _PageFrameState extends State<PageFrame> {
  int _currentIndex = 0; // default selected navbar item is "Home"
  final List _screens = [
    const HomePage(),
    const WardrobePage(),
    const AddClothesPage(),
    const CalendarPage(),
    const WeatherPage()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFFDC67F7),
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
