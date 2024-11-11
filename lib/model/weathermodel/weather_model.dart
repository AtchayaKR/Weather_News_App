import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherModel {
  //Api key from public openweatherforecast
  final String weatherApiKey = "66d255be7398a6cbdd5af52f312e4edf";

  //http method to get data
  Future<Map<String, dynamic>?> fetchWeather(
      {required double latitude,
      required double longitude,
      String? units}) async {
    try {
      final response = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$weatherApiKey&units=$units"));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("Failed to load weather data");
        return null;
      }
    } catch (e) {
      throw Exception('Could not load $e');
    }
  }

//5-day weatherforecast
  Future<List<Map<String, dynamic>>> fetchWeatherForecast({
    required double latitude,
    required double longitude,
    String units = "metric",
  }) async {
    final response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$weatherApiKey&units=$units"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<Map<String, dynamic>> forecastList = [];
      for (var item in data['list']) {
        forecastList.add(item);
      }
      return forecastList;
    } else {
      print("Failed to load forecast data");
      return [];
    }
  }
}
