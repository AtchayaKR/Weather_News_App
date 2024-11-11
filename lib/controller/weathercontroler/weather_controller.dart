import 'package:get/get.dart';
import 'package:weather_news_app/model/weathermodel/weather_model.dart';
import 'package:geolocator/geolocator.dart';

class WeatherController extends GetxController {
  final WeatherModel weatherModel = WeatherModel();
  var weatherData = <String, dynamic>{}.obs;
  var forecastData = <Map<String, dynamic>>[].obs;
  var selectedUnit = 'Celsius'.obs;

//initialize
  @override
  void onInit() {
    super.onInit();
    getLocation();
  }

  // Function to change the selected unit
  void changeUnit(String unit) {
    selectedUnit.value = unit;
    fetchLocationAndWeather();
  }

//update our latitude & longitude & call weather api
  Future<void> fetchWeatherData(double latitude, double longitude) async {
    var units = selectedUnit.value == 'Celsius'
        ? 'metric'
        : 'imperial'; // Convert to 'metric' or 'imperial'
    var data = await weatherModel.fetchWeather(
        latitude: latitude, longitude: longitude, units: units);
    if (data != null) {
      weatherData.value = data;
    }
  }

  Future<void> fetchForecastData(double latitude, double longitude) async {
    var units = selectedUnit.value == 'Celsius'
        ? 'metric'
        : 'imperial'; // Convert to 'metric' or 'imperial'
    var forecastList = await weatherModel.fetchWeatherForecast(
        latitude: latitude, longitude: longitude, units: units);
    if (forecastList.isNotEmpty) {
      forecastData.assignAll(forecastList);
    }
  }

// get lat&lon for location
  Future<void> fetchLocationAndWeather() async {
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );
    fetchWeatherData(position.latitude, position.longitude);
    fetchForecastData(position.latitude, position.longitude);
  }

//get permission to access location in device
  getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
//return if service not enabled
    if (!isServiceEnabled) {
      return Future.error('Location not enabled');
    }
//check status of device's location permission
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error('Location Permission denied forever');
    } else if (locationPermission == LocationPermission.denied) {
//request new permission again
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error('Location permission is denied');
      }
    }
    return fetchLocationAndWeather();
  }
}
