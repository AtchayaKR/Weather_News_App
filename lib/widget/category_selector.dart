import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_news_app/controller/newscontroller/news_controller.dart';

class CategorySelector extends StatelessWidget {
  final NewsController newsController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (newsController.categories.isEmpty) {
        return Center(child: CircularProgressIndicator());
      }

      return Container(
        padding: EdgeInsets.only(left: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(newsController.categories.length, (index) {
              bool isSelected =
                  index == newsController.selectedCategoryIndex.value;
              return GestureDetector(
                onTap: () => newsController.changeCategory(index),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 150),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: isSelected ? Colors.black : Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  child: Text(
                    newsController.categories[index],
                    style: TextStyle(
                      fontSize: 15,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      );
    });
  }
}
