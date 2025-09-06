import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';
import '../models/weather_forecast_model.dart';

class WeatherApiService {
  static final WeatherApiService _instance = WeatherApiService._internal();
  factory WeatherApiService() => _instance;
  WeatherApiService._internal();

  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String _apiKey = 'a9909650203ad4e51cd79566630bdb3f';

  Future<WeatherModel> fetchWeatherByCity(String cityName) async {
    final url = Uri.parse(
      '$_baseUrl/weather?q=$cityName&appid=$_apiKey&units=metric',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return WeatherModel.fromJson(jsonData);
      } else if (response.statusCode == 404) {
        throw Exception('City not found');
      } else {
        throw Exception('Failed to fetch weather data');
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Network error: Unable to fetch weather data');
    }
  }

  Future<WeatherForecastModel> fetchWeatherForecastByCity(
      String cityName) async {
    try {
      final currentWeatherUrl = Uri.parse(
        '$_baseUrl/weather?q=$cityName&appid=$_apiKey&units=metric',
      );

      final forecastUrl = Uri.parse(
        '$_baseUrl/forecast?q=$cityName&appid=$_apiKey&units=metric',
      );

      final currentWeatherResponse = await http.get(currentWeatherUrl);
      final forecastResponse = await http.get(forecastUrl);

      if (currentWeatherResponse.statusCode == 200 &&
          forecastResponse.statusCode == 200) {
        final currentWeatherJson = json.decode(currentWeatherResponse.body);
        final forecastJson = json.decode(forecastResponse.body);

        return WeatherForecastModel.fromJson(currentWeatherJson, forecastJson);
      } else if (currentWeatherResponse.statusCode == 404 ||
          forecastResponse.statusCode == 404) {
        throw Exception('City not found');
      } else {
        throw Exception('Failed to fetch weather forecast');
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Network error: Unable to fetch weather forecast');
    }
  }
}
