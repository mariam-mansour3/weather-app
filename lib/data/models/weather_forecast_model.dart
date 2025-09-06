import '../../domain/entities/weather_forecast.dart';
import 'weather_model.dart';

class WeatherForecastModel extends WeatherForecast {
  const WeatherForecastModel({
    required super.currentWeather,
    required super.dailyForecasts,
  });

  factory WeatherForecastModel.fromJson(
    Map<String, dynamic> currentWeatherJson,
    Map<String, dynamic> forecastJson,
  ) {
    final currentWeather = WeatherModel.fromJson(currentWeatherJson);

    final List<dynamic> forecastList = forecastJson['list'];
    final List<DailyForecastModel> dailyForecasts = [];

    // Group forecasts by day and take first 3 days
    final Map<String, List<dynamic>> groupedByDay = {};

    for (var item in forecastList) {
      final dateTime = DateTime.fromMillisecondsSinceEpoch(item['dt'] * 1000);
      final dayKey =
          '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';

      if (!groupedByDay.containsKey(dayKey)) {
        groupedByDay[dayKey] = [];
      }
      groupedByDay[dayKey]!.add(item);
    }

    // Take first 3 days and create daily forecasts
    final days = groupedByDay.keys.take(3);

    for (String dayKey in days) {
      final dayForecasts = groupedByDay[dayKey]!;

      // Calculate min/max temperatures for the day
      double minTemp = double.infinity;
      double maxTemp = double.negativeInfinity;
      String condition = '';
      String description = '';
      String iconCode = '';

      for (var forecast in dayForecasts) {
        final temp = (forecast['main']['temp'] as num).toDouble();
        if (temp < minTemp) minTemp = temp;
        if (temp > maxTemp) maxTemp = temp;

        // Take the condition from midday forecast (around 12:00)
        final hour =
            DateTime.fromMillisecondsSinceEpoch(forecast['dt'] * 1000).hour;
        if (hour >= 11 && hour <= 15) {
          condition = forecast['weather'][0]['main'];
          description = forecast['weather'][0]['description'];
          iconCode = forecast['weather'][0]['icon'];
        }
      }

      // Fallback if no midday forecast found
      if (condition.isEmpty) {
        final firstForecast = dayForecasts.first;
        condition = firstForecast['weather'][0]['main'];
        description = firstForecast['weather'][0]['description'];
        iconCode = firstForecast['weather'][0]['icon'];
      }

      dailyForecasts.add(DailyForecastModel(
        date: DateTime.parse(dayKey),
        maxTemp: maxTemp,
        minTemp: minTemp,
        condition: condition,
        description: description,
        iconCode: iconCode,
      ));
    }

    return WeatherForecastModel(
      currentWeather: currentWeather,
      dailyForecasts: dailyForecasts,
    );
  }
}

class DailyForecastModel extends DailyForecast {
  const DailyForecastModel({
    required super.date,
    required super.maxTemp,
    required super.minTemp,
    required super.condition,
    required super.description,
    required super.iconCode,
  });
}
