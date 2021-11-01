import 'package:flutter/material.dart';
import 'package:virtual_closet/weather.dart';
import 'package:virtual_closet/constants.dart';


class MainScreen extends StatefulWidget {
  MainScreen({required this.weatherData});

  final WeatherData weatherData;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int temperature;
  late Icon weatherDisplayIcon;
  late AssetImage backgroundImage;
  late String currentConditionText;
  late String currentLocationText;

  void updateDisplayInfo(WeatherData weatherData) {
    setState(() {
      temperature = weatherData.currentTemperature.round();
      currentConditionText = weatherData.currentConditionText;
      currentLocationText = weatherData.currentLocationText;
      WeatherDisplayData weatherDisplayData =
          weatherData.getWeatherDisplayData();
      backgroundImage = weatherDisplayData.weatherImage!;
      weatherDisplayIcon = weatherDisplayData.weatherIcon!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    updateDisplayInfo(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: backgroundImage,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 85,
            ),
            Container(
              child: weatherDisplayIcon,
            ),
            SizedBox(
              height: 15.0,
            ),
            Center(
              child: Text(
                ' $temperature°',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 80.0,
                  letterSpacing: -5,
                ),
              ),
            ),
            Center(
              child: Text(
                currentConditionText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  letterSpacing: 0,
                ),
              ),
            ),
            Center(
              child: Text(
                currentLocationText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  letterSpacing: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}