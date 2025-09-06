import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/preferences_helper.dart';
import 'data/datasources/weather_api_service.dart';
import 'data/repositories/weather_repository_impl.dart';
import 'domain/usecases/get_weather_by_city.dart';
import 'presentation/providers/weather_provider.dart';
import 'presentation/providers/theme_provider.dart';
import 'presentation/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(
          create: (_) => WeatherProvider(
            getWeatherByCity: GetWeatherByCity(
              WeatherRepositoryImpl(WeatherApiService()),
            ),
            preferencesHelper: PreferencesHelper(),
            apiService: WeatherApiService(),
          ),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Weather App',
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              primaryColor: Colors.blue.shade600,
              useMaterial3: true,
              brightness: Brightness.light,
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.blue.shade600,
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              cardTheme: const CardThemeData(
                elevation: 4,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade600,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.blue,
              primaryColor: Colors.blue.shade400,
              useMaterial3: true,
              brightness: Brightness.dark,
              scaffoldBackgroundColor: Colors.grey[900],
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.grey[900],
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              cardTheme: CardThemeData(
                color: Colors.grey[800],
                elevation: 4,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade600,
                  foregroundColor: Colors.white,
                ),
              ),
              textTheme: const TextTheme(
                bodyLarge: TextStyle(color: Colors.white),
                bodyMedium: TextStyle(color: Colors.white70),
                headlineLarge: TextStyle(color: Colors.white),
                headlineMedium: TextStyle(color: Colors.white),
                headlineSmall: TextStyle(color: Colors.white),
              ),
            ),
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
