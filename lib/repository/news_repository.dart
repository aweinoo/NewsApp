import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/models/categories_new_model.dart';
import 'package:newsapp/models/news_channel_headlines_model.dart';

class NewsRepository {
  Future<NewsChannelsHeadlinesModel> fetchNewChannelHeadlinesApi(
    String newsChannel,
  ) async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=$newsChannel&apiKey=54d0b3017eca46ba88763c8e3d7d62fe';

    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelsHeadlinesModel.fromJson(body);
    } else {
      throw Exception('Error');
    }
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async {
    String url =
        'https://newsapi.org/v2/everything?q=$category&apiKey=54d0b3017eca46ba88763c8e3d7d62fe';

    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    } else {
      throw Exception('Error');
    }
  }
}

// the-huffington-post
// the-times-of-india
// bbc-news
// bleachers-report
// australian-financial-review
// bloomberg
// buzzfeed
// cnn
// la-repubblica
// medical-news-today
// https://newsapi.org/v2/everything?q=general&apiKey=54d0b3017eca46ba88763c8e3d7d62fe
