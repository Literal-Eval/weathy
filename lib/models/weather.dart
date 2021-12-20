import 'dart:convert';
import 'package:http/http.dart' as http;

class Weather {
  static const String apiKey = 'd8fc68525449a2843190671bef978a6d';
  late double latitude;
  late double longitude;

  void setCoords(double latitude, double longitude) {
    this.latitude = latitude;
    this.longitude = longitude;
  }

  Future<dynamic> getWeather() async {
    Uri url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=${latitude.toStringAsFixed(6)}&lon=${longitude.toStringAsFixed(6)}&appid=$apiKey',
    );
    http.Response response = await http.get(url);

    return jsonDecode(response.body);
  }

  Future<dynamic> getForecast() async {
    Uri url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/forecast?lat=${latitude.toStringAsFixed(6)}&lon=${longitude.toStringAsFixed(6)}&appid=$apiKey',
    );
    http.Response response = await http.get(url);

    return jsonDecode(response.body);
  }

  Future<dynamic> getWeatherWithCity(String cityName) async {
    Uri url = Uri.parse(
      'http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey',
    );
    http.Response response = await http.get(url);

    return jsonDecode(response.body);
  }

  Future <dynamic> getForecastWithCity(String cityName) async {
    Uri url = Uri.parse(
      'http://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$apiKey',
    );
    http.Response response = await http.get(url);

    return jsonDecode(response.body);
  }
}
