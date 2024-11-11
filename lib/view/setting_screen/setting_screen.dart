import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_news_app/utils/constant.dart';
import 'package:weather_news_app/view/news_screen/news.dart';
import 'package:weather_news_app/view/weather_forecast/weatherforecast.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Settings',
            style: StoreConstant.font(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed('/home');
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      'Weather Forecast',
                      textAlign: TextAlign.center,
                      style: StoreConstant.font(fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed('/news');
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      'NEWS',
                      textAlign: TextAlign.center,
                      style: StoreConstant.font(fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
