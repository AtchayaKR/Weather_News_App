import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_news_app/controller/newscontroller/news_controller.dart';

class NewsCarousel extends StatelessWidget {
  NewsCarousel({Key? key}) : super(key: key);

  final NewsController newsController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (newsController.newsList.isEmpty) {
        return Center(child: Text("No news available"));
      }

      return CarouselSlider.builder(
        options: CarouselOptions(
          height: 250.0,
          enlargeCenterPage: true,
          autoPlay: true,
        ),
        itemCount: newsController.newsList.length,
        itemBuilder: (context, index, realIdx) {
          final news = newsController.newsList[index];
          final imageUrl = news['urlToImage'];
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: imageUrl != null
                      ? Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.transparent,
                              width: MediaQuery.of(context).size.width,
                              height: 250,
                            );
                          },
                        )
                      : Container(
                          color: Colors.black,
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                        ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xCC000000),
                        Color(0x00000000),
                        Color(0x00000000),
                        Color(0xCC000000),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      news['title'],
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
