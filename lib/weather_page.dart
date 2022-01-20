import 'package:flutter/material.dart';
import 'package:Stylophile/weather_utils.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({required this.weatherData});

  final WeatherData weatherData;

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    int temperature = widget.weatherData.currentTemperature.round();
    int minTemp = widget.weatherData.minTemp.round();
    int maxTemp = widget.weatherData.maxTemp.round();

    return SafeArea(
        child: Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: widget.weatherData.weatherImage,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 85,
            ),
            Container(
              child: widget.weatherData.weatherIcon,
            ),
            const SizedBox(
              height: 15.0,
            ),
            Center(
              child: Text(
                ' $temperature°',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 80.0,
                  letterSpacing: -5,
                ),
              ),
            ),
            Center(
              child: Text(
                widget.weatherData.currentConditionText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  letterSpacing: 0,
                ),
              ),
            ),
            Center(
              child: Text(
                widget.weatherData.currentLocationText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  letterSpacing: 0,
                ),
              ),
            ),
            Center(
              child: Text(
                'min: $minTemp° max: $maxTemp°',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  letterSpacing: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
