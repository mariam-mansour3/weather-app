import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

class GetWeatherByCity {
  final WeatherRepository repository;

  const GetWeatherByCity(this.repository);

  Future<Weather> call(String cityName) async {
    if (cityName.trim().isEmpty) {
      throw ArgumentError('City name cannot be empty');
    }
    return await repository.getWeatherByCity(cityName.trim());
  }
}
