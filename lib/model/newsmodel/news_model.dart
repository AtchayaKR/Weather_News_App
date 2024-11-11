import 'dart:convert';

import 'package:http/http.dart' as http;

class NewsModel {
  //Api key from public news_api
  final String newsApiKey = "0fee10b944fe4f39aa0c92af0291b379";

  //http method to get data
  Future<List<Map<String, dynamic>>?> fetchNews(String category) async {
    try {
      final response = await http.get(Uri.parse(
          "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=$newsApiKey"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data['articles']);
      } else {
        print("Failed to load news data");
        return null;
      }
    } catch (e) {
      throw Exception('Could not load $e');
    }
  }

// Fetch categories from an API
  Future<List<String>> fetchCategories() async {
    final response = await http.get(Uri.parse(
        "https://newsapi.org/v2/top-headlines/sources?apiKey=$newsApiKey"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<String> categories = [];
      for (var source in data['sources']) {
        String category = source['category'];
        if (!categories.contains(category)) {
          categories.add(category);
        }
      }
      return categories;
    } else {
      print("Failed to load categories");
      return [];
    }
  }
}
