import 'package:get/get.dart';
import 'package:weather_news_app/model/newsmodel/news_model.dart';

class NewsController extends GetxController {
  final NewsModel newsModel = NewsModel();
  var newsList = <Map<String, dynamic>>[].obs;
  var categories = <String>[].obs;
  var selectedCategoryIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  // Fetch news based on weather from API
  void filterNewsBasedOnWeather(String weatherCondition) async {
    String category;
    if (weatherCondition.contains('Clouds')) {
      category = 'science';
    } else if (weatherCondition.contains('Clear')) {
      category = 'entertainment';
    } else if (weatherCondition.contains('Rain')) {
      category = 'health';
    } else {
      category = 'general';
    }

    var news = await newsModel.fetchNews(category);
    if (news != null) {
      newsList.assignAll(news);
    }
  }

  // Fetch categories from API
  Future<void> fetchCategories() async {
    var categoryList = await newsModel.fetchCategories();
    categories
        .assignAll(categoryList); 
    if (categories.isNotEmpty) {
      fetchNewsBasedOnCategory(); 
    }
  }

  // Fetch news based on selected category
  Future<void> fetchNewsBasedOnCategory() async {
    if (categories.isEmpty) return;
    String category = categories[selectedCategoryIndex.value];
    var news = await newsModel.fetchNews(category);
    if (news != null) {
      newsList.assignAll(news);
    }
  }

  // Change selected category
  void changeCategory(int index) {
    selectedCategoryIndex.value = index;
    fetchNewsBasedOnCategory();
  }
}
