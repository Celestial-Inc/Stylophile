import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:virtual_closet/location.dart';
import 'package:virtual_closet/constants.dart';

class WeatherDisplayData {
  Icon? weatherIcon;
  AssetImage? weatherImage;

  WeatherDisplayData({@required this.weatherIcon, @required this.weatherImage});
}

class WeatherData {
  WeatherData({required this.locationData});

  LocationHelper locationData;
  double currentTemperature = 0.0;
  int currentCondition = 0;
  String currentConditionText = '';
  String currentLocationText = '';

  final String apiKey = 'b9e5caa180cca64a2fbede5f5abd8c7f';

  Future<void> getCurrentTemperature() async {
    double longitude = locationData.longitude ?? 0.0;
    double latitude = locationData.latitude ?? 0.0;

    Response response = await get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      String data = response.body;
      var currentWeather = jsonDecode(data);

      try {
        currentTemperature = currentWeather['main']['temp'];
        currentCondition = currentWeather['weather'][0]['id'];
        currentConditionText = currentWeather['weather'][0]['main'];
        currentLocationText = currentWeather['name'];
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    } else {
      // ignore: avoid_print
      print('Could not fetch temperature!');
    }
  }

  WeatherDisplayData getWeatherDisplayData() {
    if (currentCondition < 600) {
      return WeatherDisplayData(
        weatherIcon: kCloudIcon,
        weatherImage: const AssetImage('assets/images/cloud.png'),
      );
    } else {
      var now = DateTime.now();

      if (now.hour >= 15) {
        return WeatherDisplayData(
          weatherImage: const AssetImage('assets/images/night.png'),
          weatherIcon: kMoonIcon,
        );
      } else {
        return WeatherDisplayData(
          weatherIcon: kSunIcon,
          weatherImage: const AssetImage('assets/images/sunny.png'),
        );
      }
    }
  }
}
