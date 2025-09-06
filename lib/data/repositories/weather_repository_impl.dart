import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_api_service.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApiService apiService;

  const WeatherRepositoryImpl(this.apiService);

  @override
  Future<Weather> getWeatherByCity(String cityName) async {
    try {
      final weatherModel = await apiService.fetchWeatherByCity(cityName);
      return weatherModel;
    } catch (e) {
      throw Exception('Failed to get weather: ${e.toString()}');
    }
  }
}
