import 'package:http/http.dart';
import 'package:khabar_dar/models/news_channel_headings_model.dart';
import 'package:khabar_dar/repository/news_repository.dart';
import 'package:khabar_dar/view_model/categories_news_model.dart';

class NewsViewModel {
  final _rep = NewsRepository();
  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesApi(
      String channelName) async {
    final response = await _rep.fetchNewsChannelHeadlinesApi(channelName);
    return response;
  }

  //For Categories
  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String channelName) async {
    final response = await _rep.fetchCategoriesNewsApi(channelName);
    return response;
  }
}
