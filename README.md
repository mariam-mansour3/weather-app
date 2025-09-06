# Flutter Weather App

A clean, simple weather forecast application built with Flutter following **Clean Architecture** principles and **SOLID** design patterns.

## 🌦️ Features

- **Search Weather by City**: Enter any city name to get current weather information
- **Real-time Weather Data**: Displays temperature, weather condition, and description
- **Weather Icons**: Visual representation of current weather conditions
- **Loading States**: Shows loading indicator while fetching data
- **Error Handling**: Displays user-friendly error messages for invalid cities or API failures
- **Responsive Design**: Clean and intuitive user interface
- **Dark Mode Support** 
- **Last Searched City Memory** 
- **3-Day Forecast** 

## 🏗️ Architecture

This project follows **Clean Architecture** principles with clear separation of concerns:

### Domain Layer (`lib/domain/`)
- **Entities**: Core business models (`weather.dart`,`weather_forecast.dart`)
- **Use Cases**: Business logic (`get_weather_by_city.dart`)
- **Repository Interfaces**: Abstract contracts (`weather_repository.dart`)

### Data Layer (`lib/data/`)
- **Models**: Data transfer objects with JSON serialization (`weather_forecast_model.dart`, `weather_model.dart`)
- **Data Sources**: API service implementation (`weather_api_service.dart`)
- **Repository Implementation**: Concrete implementation of domain repository (`weather_repository_impl.dart`)

### Presentation Layer (`lib/presentation/`)
- **Screens**: UI screens (`home_screen.dart`)
- **Widgets**: Reusable UI components
  - `city_search_widget.dart`
  - `forecast_widget.dart`
  - `search_widget.dart`
  - `weather_display_widget.dart`
- **Providers**: State management (`theme_provider.dart`, `weather_provider.dart`)

## 🎯 SOLID Principles Implementation

### Single Responsibility Principle (S)
- Each class has one reason to change
- `WeatherApiService`: Only handles API calls
- `WeatherRepository`: Only manages data operations
- `GetWeatherByCity`: Only executes weather retrieval logic

### Open/Closed Principle (O)
- Easy to extend for new features (7-day forecast, multiple weather APIs)
- Repository interface allows adding new data sources without modifying existing code

### Liskov Substitution Principle (L)
- Repository implementation can be substituted with mock implementations for testing
- Abstract `IWeatherRepository` interface ensures consistent behavior

### Interface Segregation Principle (I)
- Small, focused interfaces (`IWeatherRepository` only contains necessary methods)
- No forced implementation of unused methods

### Dependency Inversion Principle (D)
- High-level modules depend on abstractions, not concrete implementations
- Use cases depend on repository interface, not concrete repository
- Easy dependency injection for testing

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (^3.0.0)
- Dart SDK (^3.0.0)
- OpenWeather API key

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/mariam-mansour3/weather-app
   cd flutter-weather-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Get API Key**
   - Sign up at [OpenWeatherMap](https://openweathermap.org/api)
   - Get your free API key
   - Add it to your environment or constants file

4. **Configure API Key**
   ```dart
   // lib/data/datasources/weather_api_service.dart
   class Constants {
     static const String apiKey = 'YOUR_API_KEY_HERE';
     static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
   }
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

## 📁 Project Structure

```
lib/
├── core/                          # Core utilities and constants
│   ├── constants.dart
│   └── preferences_helper.dart
├── data/                          # Data layer
│   ├── datasources/
│   │   └── weather_api_service.dart
│   ├── models/
│   │   ├── weather_forecast_model.dart
│   │   └── weather_model.dart
│   └── repositories/
│       └── weather_repository_impl.dart
├── domain/                        # Domain layer
│   ├── entities/
│   │   ├── weather.dart
│   │   └── weather_forecast.dart
│   ├── repositories/
│   │   └── weather_repository.dart
│   └── usecases/
│       └── get_weather_by_city.dart
└── presentation/                  # Presentation layer
    ├── providers/
    │   ├── theme_provider.dart
    │   └── weather_provider.dart
    ├── screens/
    │   └── home_screen.dart
    └── widgets/
        ├── city_search_widget.dart
        ├── forecast_widget.dart
        ├── search_widget.dart
        └── weather_display_widget.dart
```

## 🔧 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.5           # State management
  http: ^1.1.0              # HTTP requests
  shared_preferences: ^2.2.2 # Local storage
  intl: ^0.19.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
```

## 🎨 Design Patterns Used

### Repository Pattern
- Abstracts data access logic
- Provides clean API for data operations
- Enables easy testing with mock implementations

### Factory Pattern
- Used in model classes for JSON deserialization
- Centralized object creation logic

### Singleton Pattern
- API service instance management
- Shared preferences helper

### Provider Pattern
- State management across the application
- Reactive UI updates

## 📱 Screenshots

### 🏠 Main Interface & Weather Display
<table>
  <tr>
    <td align="center">
      <img src="screenshots/07-empty-state-dark.png" width="250px" alt="Home Screen - Dark Mode"/>
      <br />
      <sub><b>Empty State - Dark Mode</b></sub>
    </td>
    <td align="center">
      <img src="screenshots/08-empty-state-light.png" width="250px" alt="Home Screen - Light Mode"/>
      <br />
      <sub><b>Empty State - Light Mode</b></sub>
    </td>
    <td align="center">
      <img src="screenshots/04-search-interface.png" width="250px" alt="Search Interface"/>
      <br />
      <sub><b>Search Interface</b></sub>
    </td>
  </tr>
</table>

### 🔍 Search & Loading States
<table>
  <tr>
    <td align="center">
      <img src="screenshots/06-search-suggestions.png" width="250px" alt="Search Suggestions"/>
      <br />
      <sub><b>Auto-complete Suggestions</b></sub>
    </td>
    <td align="center">
      <img src="screenshots/05-loading-state.png" width="250px" alt="Loading State"/>
      <br />
      <sub><b>Loading State</b></sub>
    </td>
    <td align="center">
      <img src="screenshots/02-weather-with-location.png" width="250px" alt="Weather with Location"/>
      <br />
      <sub><b>Weather Display with Location</b></sub>
    </td>
  </tr>
</table>

### 🌤️ Weather Display & Theme Modes
<table>
  <tr>
    <td align="center">
      <img src="screenshots/01-weather-display-dark.png" width="250px" alt="Weather Display - Dark"/>
      <br />
      <sub><b>Dark Mode Display</b></sub>
    </td>
    <td align="center">
      <img src="screenshots/03-weather-display-light.png" width="250px" alt="Weather Display - Light"/>
      <br />
      <sub><b>Light Mode Display</b></sub>
    </td>
    <td align="center">
      <img src="screenshots/01-weather-display-dark.png" width="250px" alt="3-Day Forecast"/>
      <br />
      <sub><b>3-Day Forecast</b></sub>
    </td>
  </tr>
</table>

### ✨ Key Features Demonstrated:

#### 🎨 **Beautiful UI/UX Design**
- Modern gradient backgrounds with smooth transitions
- Clean card-based layout with proper spacing
- Intuitive weather icons and visual indicators
- Professional typography and color scheme

#### 🌓 **Dual Theme Support**
- **Dark Mode**: Elegant dark theme with blue gradients
- **Light Mode**: Clean light theme with warm gradient accents
- Persistent theme selection across app sessions
- Seamless theme switching with smooth transitions

#### 🔍 **Smart Search Experience**
- Auto-complete city suggestions while typing
- Real-time search suggestions from multiple locations
- Clean search interface with city icons
- Keyboard-friendly input with search button

#### 📊 **Comprehensive Weather Data**
- **Current Weather**: Temperature, condition, and description
- **3-Day Forecast**: Extended weather predictions with icons
- **Weather Details**: Complete breakdown with icons and labels
- **Location Display**: Clear city identification with location pins

#### ⚡ **Smooth User Experience**
- Loading states with elegant spinners and messages
- Responsive design across different screen sizes
- Smooth animations and transitions
- Professional loading indicators during API calls

#### 🏗️ **Technical Excellence**
- Clean Architecture implementation visible in UI organization
- Proper state management with loading and error states
- Real-time data updates with "Just now" timestamps
- Professional API integration with OpenWeather service

## 🧪 Testing

Run the test suite:
```bash
flutter test
```

The project includes:
- Unit tests for business logic
- Widget tests for UI components
- Integration tests for complete user flows

## 🌟 Bonus Features

### Dark Mode
- Toggle between light and dark themes
- Persistent theme selection
- Consistent styling across modes

### Last Searched City
- Remembers last searched location
- Auto-loads on app startup
- Uses SharedPreferences for persistence

### 3-Day Forecast
- Extended weather information
- Multiple day forecast display
- Enhanced user experience

## 🚀 Future Enhancements

- [ ] 7-day weather forecast
- [ ] Weather maps integration
- [ ] Multiple city favorites
- [ ] Weather notifications
- [ ] Offline data caching
- [ ] Location-based weather
- [ ] Weather widgets

## 🤝 Contributing

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [OpenWeatherMap API](https://openweathermap.org/api) for weather data
- Flutter team for the amazing framework
- Clean Architecture principles by Robert C. Martin

## 📞 Contact

Your Name - your.email@example.com
Project Link: [https://github.com/mariam-mansour3/weather-app](https://github.com/mariam-mansour3/weather-app)