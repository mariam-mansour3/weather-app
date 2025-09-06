import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchPressed() {
    final cityName = _textController.text.trim();
    if (cityName.isNotEmpty) {
      context.read<WeatherProvider>().searchWeather(cityName);
      _focusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _textController,
              focusNode: _focusNode,
              decoration: const InputDecoration(
                labelText: 'Enter city name',
                hintText: 'e.g., London, New York',
                prefixIcon: Icon(Icons.location_city),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => _onSearchPressed(),
            ),
            const SizedBox(height: 16),
            Consumer<WeatherProvider>(
              builder: (context, provider, child) {
                return ElevatedButton.icon(
                  onPressed: provider.isLoading ? null : _onSearchPressed,
                  icon: provider.isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.search),
                  label: Text(provider.isLoading ? 'Searching...' : 'Search'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
