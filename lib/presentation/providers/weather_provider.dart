import 'package:flutter/material.dart';
import '../../core/preferences_helper.dart';
import '../../domain/entities/weather.dart';
import '../../domain/entities/weather_forecast.dart';
import '../../domain/usecases/get_weather_by_city.dart';
import '../../data/datasources/weather_api_service.dart';

enum WeatherState { initial, loading, loaded, error }

class WeatherProvider extends ChangeNotifier {
  final GetWeatherByCity getWeatherByCity;
  final PreferencesHelper preferencesHelper;
  final WeatherApiService apiService;

  WeatherProvider({
    required this.getWeatherByCity,
    required this.preferencesHelper,
    required this.apiService,
  });

  Weather? _weather;
  WeatherForecast? _weatherForecast;
  WeatherState _state = WeatherState.initial;
  String _errorMessage = '';

  Weather? get weather => _weather;
  WeatherForecast? get weatherForecast => _weatherForecast;
  WeatherState get state => _state;
  String get errorMessage => _errorMessage;

  bool get isLoading => _state == WeatherState.loading;
  bool get hasError => _state == WeatherState.error;
  bool get hasData => _state == WeatherState.loaded && _weather != null;
  bool get hasForecast => _weatherForecast != null;

  Future<void> searchWeather(String cityName) async {
    _state = WeatherState.loading;
    _errorMessage = '';
    _weatherForecast = null;
    notifyListeners();

    try {
      // Get current weather
      _weather = await getWeatherByCity(cityName);

      // Get forecast
      _weatherForecast = await apiService.fetchWeatherForecastByCity(cityName);

      _state = WeatherState.loaded;

      // Save last searched city
      await preferencesHelper.saveLastSearchedCity(cityName);
    } catch (e) {
      _state = WeatherState.error;
      _errorMessage = e.toString().replaceAll('Exception: ', '');
    }

    notifyListeners();
  }

  Future<void> loadLastSearchedCity() async {
    final lastCity = await preferencesHelper.getLastSearchedCity();
    if (lastCity != null && lastCity.isNotEmpty) {
      await searchWeather(lastCity);
    }
  }

  void clearWeather() {
    _weather = null;
    _weatherForecast = null;
    _state = WeatherState.initial;
    _errorMessage = '';
    notifyListeners();
  }
}
