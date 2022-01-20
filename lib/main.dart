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
      .then((_) => initializeDateFormatting().then((_) => runApp(const MyApp())));
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.purpleAccent,
        systemNavigationBarColor: Colors.purpleAccent),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
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
    AddClothesPage(),
    const CalendarPage(),
    const WeatherLoaderPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              label: 'Home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'Wardrobe',
              icon: Icon(Icons.checkroom),
            ),
            BottomNavigationBarItem(
              label: 'Add',
              icon: Icon(Icons.add),
            ),
            BottomNavigationBarItem(
              label: 'Calendar',
              icon: Icon(Icons.date_range),
            ),
            BottomNavigationBarItem(
              label: 'Weather',
              icon: Icon(Icons.cloud),
            ),
          ],
        )
    );
  }
}
