import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/constants.dart';
import '../../domain/entities/weather_forecast.dart';

class ForecastWidget extends StatelessWidget {
  final List<DailyForecast> forecasts;

  const ForecastWidget({
    super.key,
    required this.forecasts,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '3-Day Forecast',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            ...forecasts.map((forecast) => _ForecastItem(forecast: forecast)),
          ],
        ),
      ),
    );
  }
}

class _ForecastItem extends StatelessWidget {
  final DailyForecast forecast;

  const _ForecastItem({required this.forecast});

  @override
  Widget build(BuildContext context) {
    final weatherIcon = WeatherIcons.getWeatherIcon(forecast.iconCode);
    final dayName = DateFormat('EEEE').format(forecast.date);
    final isToday = DateTime.now().day == forecast.date.day;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              isToday ? 'Today' : dayName,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                  ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              weatherIcon,
              style: const TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '${forecast.maxTemp.round()}°/${forecast.minTemp.round()}°',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
