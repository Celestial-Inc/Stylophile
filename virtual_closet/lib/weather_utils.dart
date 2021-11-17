import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:virtual_closet/location.dart';
import 'package:virtual_closet/weather_icons.dart';

class WeatherDisplayData {
  Icon? weatherIcon;
  AssetImage? weatherImage;

  WeatherDisplayData({@required this.weatherIcon, @required this.weatherImage});
}

class WeatherData {
  WeatherData({required this.locationData});

  LocationHelper locationData;
  double currentTemperature = 0.0;
  double minTemp = 0.0;
  double maxTemp = 0.0;
  int currentCondition = 0;
  String currentConditionText = '';
  String currentLocationText = '';

  final String apiKey = 'b9e5caa180cca64a2fbede5f5abd8c7f';

  Future<void> getCurrentTemperature() async {
    double longitude = locationData.longitude ?? 0.0;
    double latitude = locationData.latitude ?? 0.0;

    Response response =
        await get(Uri.parse('http://api.openweathermap.org/data/2.5/weather?lat=${latitude}&lon=${longitude}&appid=${apiKey}&units=metric'));

    if (response.statusCode == 200) {
      String data = response.body;
      var currentWeather = jsonDecode(data);

      try {
        currentTemperature = currentWeather['main']['temp'];
        currentCondition = currentWeather['weather'][0]['id'];
        currentConditionText = currentWeather['weather'][0]['main'];
        currentLocationText = currentWeather['name'];
        minTemp = currentWeather['main']['temp_min'];
        maxTemp = currentWeather['main']['temp_max'];
      } catch (e) {
        print(e);
      }
    } else {
      print('Could not fetch temperature!');
    }
  }

  WeatherDisplayData getWeatherDisplayData() {
    if (currentCondition < 300) {
      return WeatherDisplayData(
        weatherIcon: kStormIcon,
        weatherImage: AssetImage('assets/images/sunny.png'),
      );
    } else if (currentCondition < 500) {
      return WeatherDisplayData(
        weatherIcon: kDrizzleIcon,
        weatherImage: AssetImage('assets/images/sunny.png'),
      );
    } else if (currentCondition < 600) {
      return WeatherDisplayData(
        weatherIcon: kRainIcon,
        weatherImage: AssetImage('assets/images/sunny.png'),
      );
    } else if (currentCondition < 700) {
      return WeatherDisplayData(
        weatherIcon: kSnowIcon,
        weatherImage: AssetImage('assets/images/sunny.png'),
      );
    } else if (currentCondition < 800) {
      return WeatherDisplayData(
        weatherIcon: kLavastormIcon,
        weatherImage: AssetImage('assets/images/sunny.png'),
      );
    } else if (currentCondition == 800) {
      return WeatherDisplayData(
        weatherIcon: kSunIcon,
        weatherImage: AssetImage('assets/images/sunny.png'),
      );
    } else {
      return WeatherDisplayData(
        weatherIcon: kCloudIcon,
        weatherImage: AssetImage('assets/images/cloud.png'),
      );
    }
  }
}

const kLinearGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Colors.purple, Colors.blue],
);
