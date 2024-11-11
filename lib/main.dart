import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_news_app/view/news_screen/news.dart';
import 'package:weather_news_app/view/setting_screen/setting_screen.dart';
import 'package:weather_news_app/view/splash_screen/splashscreen.dart';
import 'package:weather_news_app/view/weather_forecast/weatherforecast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Weather_News_App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),
        GetPage(name: '/setting', page: () => SettingScreen()),
        GetPage(name: '/home', page: () => WeatherScreen()),
        GetPage(name: '/news', page: () => NewsViewPage()),
      ],
    );
  }
}
