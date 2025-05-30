import 'package:newsapp/models/categories_new_model.dart';
import 'package:newsapp/models/news_channel_headlines_model.dart';
import 'package:newsapp/repository/news_repository.dart';

class NewsViewModel {
  final _rep = NewsRepository();

  Future<NewsChannelsHeadlinesModel> fetchNewChannelHeadlinesApi(
    String channelName,
  ) async {
    final response = await _rep.fetchNewChannelHeadlinesApi(channelName);
    return response;
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsModel(String category) async {
    final response = await _rep.fetchCategoriesNewsApi(category);
    return response;
  }
}
