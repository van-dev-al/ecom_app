import 'package:ecom_app/data/repositories/tradematk/trademark_repository.dart';
import 'package:ecom_app/features/ecom/models/products/product_model.dart';
import 'package:ecom_app/utils/http/http_client.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final trademarkRepo = Get.put(TrademarkRepository());

  static const String endpoint = 'latest_products_data';
  static const List<String> allowedSpiders = [
    'tiki',
    'didongviet',
    'cellphones'
  ];

  Future<List<ProductModel>> fetchQueryProducts(
      Map<String, dynamic> query) async {
    try {
      final data = await EHttpHelper.get(endpoint, queryParams: query);

      final List<dynamic> dataList = data['data'];

      List<ProductModel> products = [];

      for (var item in dataList) {
        if (allowedSpiders.contains(item['spider'])) {
          var productJson = item['data'];
          var source = productJson['source'];

          String image = await trademarkRepo.getImageForSource(source);

          var product = ProductModel.fromJson({
            ...productJson,
            'image': image,
          });

          products.add(product);
        }
      }

      return products;
    } catch (e) {
      throw Exception('Failed to fetch products: ${e.toString()}');
    }
  }

  Future<List<ProductModel>> getProductByUrl(List<String> productUrl) async {
    try {
      final data = await EHttpHelper.get(endpoint);
      final List<dynamic> dataList = data['data'];
      List<ProductModel> products = [];

      for (var item in dataList) {
        if (productUrl.contains(item['data']['url'])) {
          var productJson = item['data'];
          var source = productJson['source'];

          String image = await trademarkRepo.getImageForSource(source);

          var product = ProductModel.fromJson({
            ...productJson,
            'image': image,
          });

          products.add(product);
        }
      }
      return products;
    } catch (e) {
      throw 'Error: $e';
    }
  }

  Future<List<ProductModel>> getFavoriteProducts(
      List<String> productUrl) async {
    try {
      final data = await EHttpHelper.get(endpoint);
      final List<dynamic> dataList = data['data'];
      List<ProductModel> products = [];

      for (var item in dataList) {
        if (productUrl.contains(item['data']['url'])) {
          var productJson = item['data'];
          var source = productJson['source'];

          String image = await trademarkRepo.getImageForSource(source);

          var product = ProductModel.fromJson({
            ...productJson,
            'image': image,
          });

          products.add(product);
        }
      }
      return products;
    } catch (e) {
      throw 'Error: $e';
    }
  }

  Future<List<ProductModel>> fetchProductsForTrademark(
      String source, Map<String, dynamic> query) async {
    try {
      final data = await EHttpHelper.get(endpoint, queryParams: query);

      final List<dynamic> dataList = data['data'];

      List<ProductModel> products = [];

      for (var item in dataList) {
        if (item['data']['source'] == source) {
          var productJson = item['data'];
          var source = productJson['source'];

          String image = await trademarkRepo.getImageForSource(source);

          var product = ProductModel.fromJson({
            ...productJson,
            'image': image,
          });

          products.add(product);
        }
      }

      return products;
    } catch (e) {
      throw 'Error';
    }
  }

  Future<List<ProductModel>> fetchProductsForSorceAndCategoryTrademark(
      String source, Map<String, dynamic> query, String categoryId) async {
    try {
      final data = await EHttpHelper.get(endpoint, queryParams: query);

      final List<dynamic> dataList = data['data'];

      List<ProductModel> products = [];

      for (var item in dataList) {
        if (item['data']['source'] == source) {
          var productJson = item['data'];
          var source = productJson['source'];

          String image = await trademarkRepo.getImageForSource(source);

          var product = ProductModel.fromJson({
            ...productJson,
            'image': image,
          });

          products.add(product);
        }
      }

      return products;
    } catch (e) {
      throw 'Error';
    }
  }

  Future<List<ProductModel>> fetchCompareProductWithNameAndCategoryId(
      String searchQuery, Map<String, dynamic> query, String categoryId) async {
    try {
      final data = await EHttpHelper.get(endpoint, queryParams: query);

      final List<dynamic> dataList = data['data'];

      List<ProductModel> products = [];

      for (var item in dataList) {
        if (item['data']['category_id'] == categoryId) {
          var productJson = item['data'];
          var source = productJson['source'];

          String image = await trademarkRepo.getImageForSource(source);

          var product = ProductModel.fromJson({
            ...productJson,
            'image': image,
          });

          products.add(product);
        }
      }

      return products;
    } catch (e) {
      throw 'Error';
    }
  }

  Future<List<ProductModel>> fetchProductsForTrademarkAndCategory(
      {required String categoryId,
      int limit = 4,
      required Map<String, dynamic>? query}) async {
    try {
      final data = await EHttpHelper.get(endpoint, queryParams: query);
      final List<dynamic> dataList = data['data'];
      List<ProductModel> products = [];

      for (var item in dataList) {
        if (item['data']['category_id'] == categoryId) {
          var productJson = item['data'];
          var source = productJson['source'];

          String image = await trademarkRepo.getImageForSource(source);

          var product = ProductModel.fromJson({
            ...productJson,
            'image': image,
          });

          products.add(product);
        }
      }

      if (limit != -1 && products.length > limit) {
        products = products.sublist(0, limit);
      }

      return products;
    } catch (e) {
      throw 'Error: $e';
    }
  }

  Future<List<ProductModel>> searchProducts(
      String keyword, Map<String, dynamic>? query) async {
    try {
      final data = await EHttpHelper.get(endpoint, queryParams: query);
      final List<dynamic> dataList = data['data'];
      List<ProductModel> products = [];

      for (var item in dataList) {
        if (allowedSpiders.contains(item['spider'])) {
          var productJson = item['data'];
          var source = productJson['source'];

          String image = await trademarkRepo.getImageForSource(source);

          var product = ProductModel.fromJson({
            ...productJson,
            'image': image,
          });

          if (product.name.toLowerCase().contains(keyword.toLowerCase()) ||
              product.trademarkModel!.source
                  .toLowerCase()
                  .contains(keyword.toLowerCase()) ||
              product.brand.toLowerCase().contains(keyword.toLowerCase()) ||
              product.model!.toLowerCase().contains(keyword.toLowerCase())) {
            products.add(product);
          }
        }
      }

      return products;
    } catch (e) {
      throw Exception('Failed to search products: ${e.toString()}');
    }
  }

  Future<List<ProductModel>> updateHomeScreenData() async {
    try {
      final List<ProductModel> products = await fetchFilteredProducts(
        limit: -1,
        query: {
          'categories': '',
          'sortBy': '',
          'page': '',
          'pageSize': '',
        },
      );

      await updateProductCount(products);
      await updateCategoryProductCounts(products);

      return products;
    } catch (e) {
      throw Exception('Failed to update home screen data: ${e.toString()}');
    }
  }

  Future<List<ProductModel>> fetchFilteredProducts({
    required int limit,
    required Map<String, dynamic>? query,
  }) async {
    try {
      final data = await EHttpHelper.get(endpoint, queryParams: query);
      final List<dynamic> dataList = data['data'];
      List<ProductModel> products = [];

      for (var item in dataList) {
        if (allowedSpiders.contains(item['spider'])) {
          var productJson = item['data'];
          var source = productJson['source'];

          String image = await trademarkRepo.getImageForSource(source);

          var product = ProductModel.fromJson({
            ...productJson,
            'image': image,
          });

          products.add(product);
        }
      }

      if (limit != -1 && products.length > limit) {
        products = products.sublist(0, limit);
      }

      products.shuffle();
      return products;
    } catch (e) {
      throw Exception('Failed to fetch products ${e.toString()}');
    }
  }

  Future<void> updateProductCount(List<ProductModel> products) async {
    Map<String, int> sourceCounts = {};

    for (var product in products) {
      String source = product.trademarkModel!.source;
      if (sourceCounts.containsKey(source)) {
        sourceCounts[source] = sourceCounts[source]! + 1;
      } else {
        sourceCounts[source] = 1;
      }
    }

    sourceCounts.forEach((source, productCount) async {
      try {
        await _firestore
            .collection('TradeMark')
            .doc(getSourceDocId(source))
            .update({
          'ProductCount': productCount,
        });
      } catch (e) {
        throw e.toString();
      }
    });
  }

  String getSourceDocId(String source) {
    switch (source) {
      case 'tiki.vn':
        return '1';
      case 'cellphones.com.vn':
        return '2';
      case 'didongviet.vn':
        return '3';
      default:
        throw Exception('Unknown source: $source');
    }
  }

  Future<void> updateCategoryProductCounts(List<ProductModel> products) async {
    Map<String, Map<String, int>> categoryCounts = {};

    for (var product in products) {
      String categoryId = product.categoryId;
      String source = product.trademarkModel!.source;

      if (!categoryCounts.containsKey(categoryId)) {
        categoryCounts[categoryId] = {};
      }

      categoryCounts[categoryId]![source] =
          (categoryCounts[categoryId]![source] ?? 0) + 1;
    }

    categoryCounts.forEach((categoryId, counts) async {
      try {
        Map<String, int> trademarkCounts = {};
        counts.forEach((source, countP) {
          trademarkCounts[source] = countP;
        });

        await _firestore
            .collection('Categories')
            .doc(getCategoryIdDocId(categoryId))
            .update({
          'TrademarkCounts': trademarkCounts,
        });
      } catch (e) {
        throw Exception(
            'Failed to update Firestore for CategoryId $categoryId: ${e.toString()}');
      }
    });
  }

  String getCategoryIdDocId(String categoryId) {
    switch (categoryId) {
      case 'mobiles':
        return '1';
      case 'tablets':
        return '2';
      case 'laptops':
        return '3';
      default:
        throw Exception('Unknown category id: $categoryId');
    }
  }
}
