import 'weather.dart';

class WeatherForecast {
  final Weather currentWeather;
  final List<DailyForecast> dailyForecasts;

  const WeatherForecast({
    required this.currentWeather,
    required this.dailyForecasts,
  });
}

class DailyForecast {
  final DateTime date;
  final double maxTemp;
  final double minTemp;
  final String condition;
  final String description;
  final String iconCode;

  const DailyForecast({
    required this.date,
    required this.maxTemp,
    required this.minTemp,
    required this.condition,
    required this.description,
    required this.iconCode,
  });
}
