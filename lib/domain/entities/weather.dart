class Weather {
  final String cityName;
  final double temperature;
  final String condition;
  final String description;
  final String iconCode;
  final DateTime timestamp;

  const Weather({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.description,
    required this.iconCode,
    required this.timestamp,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Weather &&
          runtimeType == other.runtimeType &&
          cityName == other.cityName &&
          temperature == other.temperature &&
          condition == other.condition;

  @override
  int get hashCode => Object.hash(cityName, temperature, condition);
}
