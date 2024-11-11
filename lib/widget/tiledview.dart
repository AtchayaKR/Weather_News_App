import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_news_app/controller/newscontroller/news_controller.dart';

class TiledNewsView extends StatelessWidget {
  TiledNewsView({super.key});

  // Using the GetX controller for state management
  final NewsController newsController = Get.put(NewsController());

  String formatDate(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    String formattedDate = DateFormat('MM/dd/yy').format(date);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // If the news list is empty, show a loading indicator or a placeholder
      if (newsController.newsList.isEmpty) {
        return Center(child: CircularProgressIndicator());
      }

      // Build the news list using data from the controller
      return Column(
        children: List.generate(newsController.newsList.length, (index) {
          var newsItem = newsController.newsList[index];
          int newsDescriptionLength =
              (newsItem['description'] ?? '').split(' ').length;

          return GestureDetector(
            onTap: () {
              () => _launchUrl(newsItem['url']);
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      newsItem['urlToImage'] ?? "",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.image_rounded, size: 100);
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          getTruncatedTitle(
                              newsItem['title'] ?? 'Title of the NEWS', 60),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        InkWell(
                            onTap: () => _launchUrl(newsItem['url']),
                            child: Text('To see More...Click here',
                                style: TextStyle(color: Colors.grey[700]))),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${newsDescriptionLength >= 200 ? (newsDescriptionLength / 200).floor() : (newsDescriptionLength / 200 * 60).floor()} ${newsDescriptionLength >= 200 ? "mins" : "secs"} read",
                              style: TextStyle(
                                  fontSize: 13, color: Colors.grey[700]),
                            ),
                            Text(
                              formatDate(newsItem['publishedAt'] ?? ''),
                              style: TextStyle(
                                  fontSize: 10, color: Colors.grey[500]),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      );
    });
  }

  String getTruncatedTitle(String actualString, int maxLetters) {
    return actualString.length > maxLetters
        ? actualString.substring(0, maxLetters) + "..."
        : actualString;
  }

  Future<void> _launchUrl(String url) async {
    try {
      Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      print("Error launching URL: $e");
    }
  }
}
