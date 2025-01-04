import 'package:ecom_app/features/ecom/models/news_model.dart';
import 'package:ecom_app/utils/http/http_client.dart';

class NewRepository {
  static const String endpoint = 'latest_news_data';
  static const List<String> allowedSpiders = ['sforum'];

  Future<List<NewsModel>> fetchNews({int limit = 15}) async {
    try {
      final data = await EHttpHelper.get(endpoint);
      final List<dynamic> dataList = data['data'];
      List<NewsModel> news = [];

      for (var item in dataList) {
        if (allowedSpiders.contains(item['spider'])) {
          news.add(NewsModel.fromJson(item['data']));
        }
      }
      if (limit != -1 && news.length > limit) {
        news = news.sublist(0, limit);
      }

      return news;
    } catch (e) {
      throw Exception('Error fetching news ${e.toString()}');
    }
  }
}
