// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:virtual_closet/constants.dart';
import 'package:virtual_closet/main_weather_screen.dart';
import 'package:virtual_closet/location.dart';
import 'package:virtual_closet/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late LocationHelper locationData;
  WeatherData? currentWeather;

  Future<void> getLocationData() async {
    locationData = LocationHelper();
    await locationData.getCurrentLocation();

    if (locationData.latitude == null || locationData.longitude == null) {
      // todo: Handle no location
    }
  }

  void getWeatherData() async {
    // Fetch the location
    await getLocationData();

    // Fetch the current weather
    WeatherData weatherData = WeatherData(locationData: locationData);
    await weatherData.getCurrentTemperature();

    if (weatherData.currentTemperature == null ||
        weatherData.currentCondition == null) {
      // todo: Handle no weather
    }

    setState(() {
      currentWeather = weatherData;
    });
  }

  @override
  void initState() {
    super.initState();
    getWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    if (currentWeather == null) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: kLinearGradient,
          ),
          child: const Center(
            child: SpinKitRipple(
              color: Colors.white,
              size: 150.0,
              duration: Duration(milliseconds: 1200),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: MainScreen(
          weatherData: currentWeather!,
        ),
      );
    }
  }
}
