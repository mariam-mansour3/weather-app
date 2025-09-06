class AppConstants {
  static const String appName = 'Weather App';
  static const String defaultCity = 'London';
  static const String lastSearchedCityKey = 'last_searched_city';
}

class WeatherIcons {
  static const Map<String, String> iconMap = {
    '01d': '☀️',
    '01n': '🌙',
    '02d': '⛅',
    '02n': '☁️',
    '03d': '☁️',
    '03n': '☁️',
    '04d': '☁️',
    '04n': '☁️',
    '09d': '🌧️',
    '09n': '🌧️',
    '10d': '🌦️',
    '10n': '🌧️',
    '11d': '⛈️',
    '11n': '⛈️',
    '13d': '❄️',
    '13n': '❄️',
    '50d': '🌫️',
    '50n': '🌫️',
  };

  static String getWeatherIcon(String iconCode) {
    return iconMap[iconCode] ?? '🌤️';
  }
}
