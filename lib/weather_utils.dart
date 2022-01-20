import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:Stylophile/location_helper.dart';
import 'package:Stylophile/weather_icons.dart';

/// This is the API Key that we use for OpenWeather calls
const String _apiKey = 'b9e5caa180cca64a2fbede5f5abd8c7f';

class WeatherData {
  late Icon weatherIcon;
  late AssetImage weatherImage;
  late double currentTemperature;
  late double minTemp;
  late double maxTemp;
  late int currentCondition;
  late String currentConditionText;
  late String currentLocationText;
}

Future<WeatherData> getWeatherData() async {
  LocationHelper locationHelper = LocationHelper();

  double longitude = await locationHelper.getLongitude();
  double latitude = await locationHelper.getLatitude();

  Response response = await get(Uri.parse(
      'http://api.openweathermap.org/data/2.5/weather?lat=${latitude}&lon=${longitude}&appid=${_apiKey}&units=metric'));

  if (response.statusCode == 200) {
    try {
      String data = response.body;
      var currentWeather = jsonDecode(data);
      WeatherData result = WeatherData();
      result.currentTemperature = currentWeather['main']['temp'];
      result.currentCondition = currentWeather['weather'][0]['id'];
      result.currentConditionText = currentWeather['weather'][0]['main'];
      result.currentLocationText = currentWeather['name'];
      result.minTemp = currentWeather['main']['temp_min'];
      result.maxTemp = currentWeather['main']['temp_max'];
      _fillInWeatherIcons(result);
      return result;
    } catch (e) {
      stderr.writeln(
          'WARNING: Stylophile could not read response from openweathermap.org');
      throw Exception();
    }
  } else {
    stderr.writeln(
        'WARNING: Stylophile could not contact openweathermap.org. Response code ${response.statusCode}.');
    throw Exception();
  }
}

void _fillInWeatherIcons(WeatherData weatherData) {
  if (weatherData.currentCondition < 300) {
    weatherData.weatherIcon = kStormIcon;
    weatherData.weatherImage = const AssetImage('assets/images/storm.jpg');
  } else if (weatherData.currentCondition < 500) {
    weatherData.weatherIcon = kDrizzleIcon;
    weatherData.weatherImage = const AssetImage('assets/images/drizzle.jpg');
  } else if (weatherData.currentCondition < 600) {
    weatherData.weatherIcon = kRainIcon;
    weatherData.weatherImage = const AssetImage('assets/images/rain.jpg');
  } else if (weatherData.currentCondition < 700) {
    weatherData.weatherIcon = kSnowIcon;
    weatherData.weatherImage = const AssetImage('assets/images/snow.jpg');
  } else if (weatherData.currentCondition < 800) {
    weatherData.weatherIcon = kLavastormIcon;
    weatherData.weatherImage = const AssetImage('assets/images/lavastorm.jpg');
  } else if (weatherData.currentCondition == 800) {
    weatherData.weatherIcon = kSunIcon;
    weatherData.weatherImage = const AssetImage('assets/images/clear.jpg');
  } else {
    weatherData.weatherIcon = kCloudIcon;
    weatherData.weatherImage = const AssetImage('assets/images/clouds.jpg');
  }
}

const kLinearGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Colors.purple, Colors.blue],
);
