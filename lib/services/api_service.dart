import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiServices {
  String _apiKey = '32ac1a3ff6f742d1ace42829200408';
  String baseUrl = 'https://api.weatherapi.com/v1';
  getCurrentLocationWeatherForecast(double lat, double long) async {
    try {
      String url = '$baseUrl/forecast.json?key=$_apiKey&q=$lat,$long&days=7';
      final response = await http.get(url);
      if (response.statusCode >= 200 && response.statusCode < 400) {
        return jsonDecode(response.body);
      } else {
        return jsonDecode(response.body);
      }
    } catch (e) {}
  }

  getCityWeatherForecast(String city) async {
    try {
      String url = '$baseUrl/forecast.json?key=$_apiKey&q=$city&days=7';
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      // else {
      //   return jsonDecode(response.body);
      // }
    } catch (e) {}
  }
}
