import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_news_app/controller/newscontroller/news_controller.dart';
import 'package:weather_news_app/controller/weathercontroler/weather_controller.dart';
import 'package:weather_news_app/widget/news_carousal.dart';

class HomeScreen extends StatelessWidget {
  final WeatherController weatherController = Get.put(WeatherController());
  final NewsController newsController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Weather and News App")),
      body: SafeArea(
        child: Column(
          children: [
            Obx(() {
              var weather = weatherController.weatherData.value;
              if (weather.isNotEmpty) {
                return Column(
                  children: [
                    Text("Name:${weather['name']}"),
                    Text("Temperature: ${weather['main']['temp']}°C"),
                    Text("Condition: ${weather['weather'][0]['description']}"),
                    ElevatedButton(
                      onPressed: () {
                        newsController.filterNewsBasedOnWeather(
                            weather['weather'][0]['description']);
                      },
                      child: Text("Get News Based on Weather"),
                    ),
                  ],
                );
              } else {
                return CircularProgressIndicator();
              }
            }),
            SizedBox(height: 20),
            NewsCarousel(),
          ],
        ),
      ),
    );
  }

}
