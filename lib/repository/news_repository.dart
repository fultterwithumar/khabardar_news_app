import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:khabar_dar/models/news_channel_headings_model.dart';
import 'package:khabar_dar/view_model/categories_news_model.dart';

class NewsRepository {
  //For Headline
  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesApi(
      String channelName) async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=$channelName&apiKey=de90418811464720ba6f1c7dbdfdec69';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelsHeadlinesModel.fromJson(body);
    }
    throw Exception("Error in news repostior");
  }

  //For Catagories
  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String categories) async {
    String url =
        'https://newsapi.org/v2/everything?q=${categories}&apiKey=de90418811464720ba6f1c7dbdfdec69';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    }
    throw Exception("Error in news repostior");
  }
}
