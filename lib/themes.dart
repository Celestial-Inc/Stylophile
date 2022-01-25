import 'package:flutter/material.dart';

CustomTheme currentTheme = CustomTheme();

class CustomTheme with ChangeNotifier {
  static bool _ispurpleTheme = true;
  ThemeMode get currentTheme =>
      _ispurpleTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _ispurpleTheme = !_ispurpleTheme;
    notifyListeners();
  }

  static ThemeData get pinkTheme {
    return ThemeData(
        primaryColor: Colors.pink[500],
        backgroundColor: Colors.pink[200],
        scaffoldBackgroundColor: Colors.pink[200],
        textTheme: TextTheme(
            headline1: TextStyle(color: Colors.white),
            headline2: TextStyle(color: Colors.white),
            bodyText1: TextStyle(color: Colors.white),
            bodyText2: TextStyle(color: Colors.white)));
  }

  static ThemeData get purpleTheme {
    return ThemeData(
        primaryColor: Colors.purple[700],
        backgroundColor: Colors.purple[600],
        scaffoldBackgroundColor: Colors.purple[700],
        textTheme: TextTheme(
            headline1: TextStyle(color: Colors.white),
            headline2: TextStyle(color: Colors.white),
            bodyText1: TextStyle(color: Colors.white),
            bodyText2: TextStyle(color: Colors.white)));
  }
}
