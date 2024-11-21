import 'package:flutter/material.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/widgets/button.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  final TextEditingController _controller = TextEditingController();
  String _cityName = '';
  Weather? _weather;
  String _errorMessage = '';

  void _getWeather() async {
    if (_controller.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a city name.';
      });
      return;
    }

    final weather = await _weatherService.fetchWeather(_controller.text);
    if (weather == null) {
      setState(() {
        _errorMessage = 'Unable to fetch weather.';
        _weather = null; // Reset weather data if an error occurs
      });
    } else {
      setState(() {
        _weather = weather;
        _errorMessage = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 40),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter City Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            Button(
              label: "Get Weather",
              style: const TextStyle(fontSize: 18),
              onPressed: _getWeather,
            ),
            const SizedBox(height: 20),
            // Error message display
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            // Weather info display
            if (_weather != null)
              Column(
                children: <Widget>[
                  Text(
                    'Weather in ${_controller.text}', // Show city name from the controller
                    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text('Temperature: ${_weather!.temperature.toStringAsFixed(1)}°C'),
                  Text('Weather: ${_weather!.description}'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
