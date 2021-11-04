import 'package:flutter/material.dart';
import 'package:virtual_closet/loading_screen.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoadingScreen(),
    );
  }
}
