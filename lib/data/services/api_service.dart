import 'dart:convert';

import 'package:ecom_app/features/ecom/models/news_model.dart';
import 'package:ecom_app/features/ecom/models/products/product_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://127.0.0.1:5000/latest_data";

  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> dataList = data['data'];

        //
        List<ProductModel> products = [];
        for (var item in dataList) {
          List<String> allowedSpiders = ['tiki', 'didongviet', 'cellphones'];
          if (allowedSpiders.contains(item['spider'])) {
            products.add(ProductModel.fromSnapshot(item['data']));
          }
        }

        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to fetching products');
    }
  }

  Future<List<NewsModel>> fetchNews() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> dataList = data['data'];

        List<NewsModel> news = [];
        for (var item in dataList) {
          if (item['spider'] == 'sforum') {
            news.add(NewsModel.fromJson(item['data']));
          }
        }

        return news;
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Error fetching news');
    }
  }
}
