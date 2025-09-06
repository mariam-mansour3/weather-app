import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';

class PreferencesHelper {
  static final PreferencesHelper _instance = PreferencesHelper._internal();
  factory PreferencesHelper() => _instance;
  PreferencesHelper._internal();

  Future<void> saveLastSearchedCity(String cityName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.lastSearchedCityKey, cityName);
  }

  Future<String?> getLastSearchedCity() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.lastSearchedCityKey);
  }
}
