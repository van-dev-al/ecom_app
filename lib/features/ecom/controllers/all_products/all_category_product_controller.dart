import 'package:ecom_app/common/widgets/loaders/loaders.dart';
import 'package:ecom_app/data/repositories/products/product_repository.dart';
import 'package:ecom_app/features/ecom/models/products/product_model.dart';
import 'package:get/get.dart';

class AllCategoryProductController extends GetxController {
  static AllCategoryProductController get instance => Get.find();

  final repository = ProductRepository.instance;
  final RxString selectedSortOption = ''.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;

  final RxBool isLoadingMore = false.obs;
  int currentPage = 1;
  bool hasMoreData = true;

  Future<List<ProductModel>> getTrademarkCategoryProducts({
    required String categoryId,
    int limit = 4,
    required Map<String, dynamic>? query,
  }) async {
    try {
      final products = await ProductRepository.instance
          .fetchProductsForTrademarkAndCategory(
              categoryId: categoryId, limit: limit, query: query);
      return products;
    } catch (e) {
      ELoader.errorSnackBar(
          title: 'Opp! Something went wrong.', message: e.toString());
      return [];
    }
  }

  void sortProducts(String categoryId, String sortOption) {
    selectedSortOption.value = sortOption;

    String sortBy = getSortByValue(sortOption);

    Map<String, dynamic> query = {
      'sortBy': sortBy,
      'page': '1',
      'pageSize': '10',
      'categories': categoryId,
    };

    getTrademarkCategoryProducts(categoryId: categoryId, query: query)
        .then((fetchedProducts) {
      if (fetchedProducts.isNotEmpty) {
        assignProducts(fetchedProducts);
        hasMoreData = true;
        currentPage = 1;
      }
    });
  }

  String getSortByValue(String sortOption) {
    switch (sortOption) {
      case '':
        return '';
      case 'Name':
        return 'name';
      case 'Higher Price':
        return 'current_price_asc';
      case 'Lower Price':
        return 'current_price_desc';
      case 'Discount':
        return 'discount_rate';
      case 'Reviews':
        return 'review_count';
      default:
        return '';
    }
  }

  void loadMoreProducts(String categoryId) async {
    if (isLoadingMore.value || !hasMoreData) return;

    isLoadingMore.value = true;
    currentPage++;

    Map<String, dynamic> query = {
      'sortBy': getSortByValue(selectedSortOption.value),
      'page': '$currentPage',
      'pageSize': '10',
      'categories': categoryId,
    };

    final fetchedProducts = await getTrademarkCategoryProducts(
        query: query, categoryId: categoryId);

    if (fetchedProducts.isNotEmpty) {
      products.addAll(fetchedProducts);
    } else {
      hasMoreData = false;
    }

    isLoadingMore.value = false;
  }

  void assignProducts(List<ProductModel> newProducts) {
    products.assignAll(newProducts);
  }
}
