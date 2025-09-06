import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class CitySearchWidget extends StatefulWidget {
  const CitySearchWidget({super.key});

  @override
  State<CitySearchWidget> createState() => _CitySearchWidgetState();
}

class _CitySearchWidgetState extends State<CitySearchWidget> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<String> _suggestions = [];
  bool _showSuggestions = false;

  final List<String> _popularCities = [
    'Cairo',
    'Alexandria',
    'Giza',
    'Port Said',
    'Suez',
    'Luxor',
    'Aswan',
    'Mansoura',
    'Tanta',
    'Asyut',
    'Ismailia',
    'Fayyum',
    'Zagazig',
    'Damietta',
    'Minya',
    'Damanhur',
    'Beni Suef',
    'Hurghada',
    'Qena',
    'Sohag',
    'Shibin El Kom',
    'Banha',
    'Kafr El Sheikh',
    'Arish',
    'Mallawi',
    'Bilbays',
    'Marsa Matruh',
    'Edfu',
    'Mit Ghamr',
    'Al-Hamidiyya',
    'Desouk',
    'Qalyub',
    'Abu Kabir',
    'Kafr El Dawwar',
    'Girga',
    'Akhmim',
    'Matareya',
    'London',
    'Paris',
    'New York',
    'Tokyo',
    'Dubai',
    'Istanbul',
    'Rome',
    'Madrid',
    'Berlin',
    'Amsterdam',
    'Barcelona',
    'Vienna',
    'Prague',
    'Budapest',
    'Moscow',
    'Sydney',
    'Melbourne',
    'Toronto',
    'Vancouver',
    'Los Angeles',
    'Chicago',
    'Miami',
    'Las Vegas',
    'San Francisco',
    'Seattle',
    'Boston',
    'Washington',
    'Atlanta',
    'Phoenix',
    'Philadelphia',
    'Houston',
    'Dallas',
    'Denver',
    'Portland',
    'Nashville',
    'Austin',
    'Orlando',
    'Tampa',
    'Charlotte',
    'Raleigh',
    'Pittsburgh',
    'Cincinnati',
    'Cleveland',
    'Detroit',
    'Milwaukee',
    'Minneapolis',
    'Kansas City',
    'St. Louis',
    'New Orleans',
    'Memphis',
    'Birmingham',
    'Louisville',
    'Richmond',
    'Norfolk',
    'Savannah',
    'Charleston',
    'Jacksonville',
    'Tallahassee',
    'Baton Rouge',
    'Shreveport',
    'Little Rock',
    'Jackson',
    'Montgomery',
    'Mobile',
    'Huntsville',
    'Knoxville',
    'Chattanooga',
    'Columbia',
    'Greenville',
    'Asheville',
    'Wilmington',
    'Fayetteville',
    'Greensboro',
    'Winston-Salem',
    'Durham',
    'Chapel Hill',
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _focusNode.removeListener(_onFocusChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final query = _controller.text.trim();

    if (query.isEmpty) {
      setState(() {
        _suggestions = [];
        _showSuggestions = false;
      });
      return;
    }

    final filteredCities = _popularCities
        .where((city) => city.toLowerCase().contains(query.toLowerCase()))
        .take(5)
        .toList();

    setState(() {
      _suggestions = filteredCities;
      _showSuggestions = filteredCities.isNotEmpty && _focusNode.hasFocus;
    });
  }

  void _onFocusChanged() {
    if (!_focusNode.hasFocus) {
      Future.delayed(const Duration(milliseconds: 150), () {
        if (mounted) {
          setState(() {
            _showSuggestions = false;
          });
        }
      });
    } else {
      _onTextChanged();
    }
  }

  void _selectSuggestion(String city) {
    _controller.text = city;
    setState(() {
      _showSuggestions = false;
    });
    _focusNode.unfocus();
    _searchWeather(city);
  }

  void _searchWeather(String cityName) {
    if (cityName.trim().isNotEmpty) {
      context.read<WeatherProvider>().searchWeather(cityName.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            decoration: InputDecoration(
              hintText: 'Enter city name',
              prefixIcon: const Icon(Icons.location_city),
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => _searchWeather(_controller.text),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.white,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
            onSubmitted: _searchWeather,
            textInputAction: TextInputAction.search,
          ),
        ),
        if (_showSuggestions && _suggestions.isNotEmpty) ...[
          const SizedBox(height: 4),
          Container(
            constraints: const BoxConstraints(maxHeight: 200),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: _suggestions.length,
              itemBuilder: (context, index) {
                final city = _suggestions[index];
                return ListTile(
                  dense: true,
                  leading: const Icon(Icons.location_on, size: 20),
                  title: Text(
                    city,
                    style: const TextStyle(fontSize: 14),
                  ),
                  onTap: () => _selectSuggestion(city),
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}
