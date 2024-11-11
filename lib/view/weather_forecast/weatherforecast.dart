import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_news_app/controller/weathercontroler/weather_controller.dart';
import 'package:weather_news_app/widget/news_carousal.dart';

class WeatherScreen extends StatelessWidget {
  final WeatherController weatherController = Get.put(WeatherController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // Dropdown button to select unit
          Obx(() {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<String>(
                value: weatherController.selectedUnit.value,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    weatherController.changeUnit(newValue); // Change unit
                  }
                },
                items: <String>['Celsius', 'Fahrenheit']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            );
          }),
        ],
      ),
      body: Obx(() {
        if (weatherController.weatherData.isEmpty ||
            weatherController.forecastData.isEmpty) {
          return Center(child: CircularProgressIndicator());
        } else {
          var currentWeather = weatherController.weatherData.value;
          var forecastList = weatherController.forecastData.value;

          return SingleChildScrollView(
            child: Column(
              children: [
                CurrentWeatherCard(currentWeather),
                ForecastList(forecastList),
                SizedBox(
                  height: 10,
                ),
                Text('Headlines',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    )),
                SizedBox(height: 10),
                NewsCarousel(),
              ],
            ),
          );
        }
      }),
    );
  }
}

// currentweather widget
class CurrentWeatherCard extends StatelessWidget {
  final Map<String, dynamic> currentWeather;

  CurrentWeatherCard(this.currentWeather);

  @override
  Widget build(BuildContext context) {
    final weatherController = Get.find<WeatherController>();
    var name = currentWeather['name'];
    var temperature = currentWeather['main']['temp'];
    var weatherDescription = currentWeather['weather'][0]['description'];
    var icon = currentWeather['weather'][0]['icon'];

    return Card(
      child: Column(
        children: [
          Image.network('https://openweathermap.org/img/wn/$icon@2x.png'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.location_pin), Text('$name')],
          ),
          Text(
            '${weatherController.selectedUnit.value == 'Celsius' ? temperature : ((temperature * 9 / 5) + 32).toStringAsFixed(2)}°${weatherController.selectedUnit.value == 'Celsius' ? 'C' : 'F'}',
            style: TextStyle(fontSize: 36),
          ),
          Text(
            weatherDescription,
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

//Forecastlist widget
class ForecastList extends StatelessWidget {
  final List<Map<String, dynamic>> forecastList;

  ForecastList(this.forecastList);

  String getDay(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    String dayOfWeek = DateFormat('EEE').format(date);
    return dayOfWeek;
  }

  @override
  Widget build(BuildContext context) {
    final weatherController = Get.find<WeatherController>();

    return Container(
      height: 250,
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: forecastList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          var forecast = forecastList[index];
          var date = getDay(forecast['dt_txt']);
          var temperature = forecast['main']['temp'];
          var icon = forecast['weather'][0]['icon'];
          var climate = forecast['weather'][0]['main'];

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 185,
                  width: 120,
                  color: Colors.grey.withOpacity(0.2),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey[400],
                          radius: 35,
                          child: Image.network(
                            'https://openweathermap.org/img/wn/$icon@2x.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('$date'),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${weatherController.selectedUnit.value == 'Celsius' ? temperature : ((temperature * 9 / 5) + 32).toStringAsFixed(2)}°',
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('$climate'),
                      ],
                    )),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
