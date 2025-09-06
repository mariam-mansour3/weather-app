import '../entities/weather.dart';

abstract class WeatherRepository {
  Future<Weather> getWeatherByCity(String cityName);
}
