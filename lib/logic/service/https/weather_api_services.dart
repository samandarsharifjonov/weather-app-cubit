import 'dart:convert';

import 'package:weathet_app_bloc/data/models/weather.dart';

import 'package:http/http.dart' as http;

import '../../../data/constants/constants.dart';
import '../exceptions/weather_exceptions.dart';

class WeatherApiServices {
  final http.Client client;

  WeatherApiServices({required this.client});

  Future<Weather> getWeather(String city) async {
    final uri = Uri.parse(
        '$base_uri?q=${city.toLowerCase()}&units=metric&appid=$api_key');

    try {
      final response = await client.get(uri);
      if (response.statusCode >= 400) {
        throw WeatherExceptions("NOT FOUND");
      }
      final responseBody = jsonDecode(response.body);
      if (responseBody == null) {
        throw WeatherExceptions("Cannot get weather $city");
      }
      final data = responseBody as Map<String, dynamic>;
      final weatherData = data['weather'][0];
      final mainData = data['main'];
      final windData = data['wind'];

      final Weather weather = Weather(
        id: weatherData['id'].toString(),
        main: weatherData['main'],
        description: weatherData['description'],
        icon: weatherData['icon'],
        temp: double.parse(mainData['temp'].toString()),
        city: city,
        wind: double.parse(windData['speed'].toString()),
        humidity: double.parse(mainData['humidity'].toString()),
      );
      return weather;
    } catch (e) {
      rethrow;
    }
  }
}
