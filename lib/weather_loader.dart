import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:Stylophile/weather_page.dart';
import 'package:Stylophile/location.dart';
import 'package:Stylophile/weather_utils.dart';

class WeatherLoaderPage extends StatefulWidget {
  @override
  _WeatherLoaderPageState createState() => _WeatherLoaderPageState();
}

class _WeatherLoaderPageState extends State<WeatherLoaderPage> {
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
      return new Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: kLinearGradient,
          ),
          child: Center(
            child: SpinKitRipple(
              color: Colors.white,
              size: 150.0,
              duration: Duration(milliseconds: 1200),
            ),
          ),
        ),
      );
    } else {
      return new Scaffold(
        body: WeatherPage(
          weatherData: currentWeather!,
        ),
      );
    }
  }
}