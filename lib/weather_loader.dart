import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:Stylophile/weather_page.dart';
import 'package:Stylophile/weather_utils.dart';

class WeatherLoaderPage extends StatefulWidget {
  const WeatherLoaderPage({Key? key}) : super(key: key);

  @override
  _WeatherLoaderPageState createState() => _WeatherLoaderPageState();
}

class _WeatherLoaderPageState extends State<WeatherLoaderPage> {
  WeatherData? currentWeather;
  bool weatherNotAvailable = false;

  @override
  void initState() {
    super.initState();
    lookupWeatherData();
  }

  Future<void> lookupWeatherData() async {
    try {
      WeatherData weather = await getWeatherData();
      setState(() {
        currentWeather = weather;
      });
    } catch (e) {
      setState(() {
        weatherNotAvailable = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (weatherNotAvailable) {
      return buildWeatherMissingMessage();
    }

    if (currentWeather == null) {
      return buildLoadingIndicator();
    }

    return buildWeatherPage();
  }

  Widget buildWeatherMissingMessage() {
    return const Scaffold(
      body: Text("Could not find weather"),
    );
  }

  Widget buildWeatherPage() {
    return Scaffold(
      body: WeatherPage(
        weatherData: currentWeather!,
      ),
    );
  }

  Widget buildLoadingIndicator() {
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
  }
}
