import 'package:ecom_app/common/widgets/loaders/loaders.dart';
import 'package:ecom_app/data/repositories/products/product_repository.dart';
import 'package:ecom_app/features/ecom/models/products/product_model.dart';
import 'package:get/get.dart';

class CompareProductController extends GetxController {
  static CompareProductController get instance => Get.find();

  final RxBool isLoading = false.obs;
  final RxString selectedSortOption = ''.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;
  int currentPage = 1;
  bool hasMoreData = true;

  Future<List<ProductModel>> getCompareProduct(
      String searchQuery, Map<String, dynamic> query, String categoryId) async {
    try {
      query['searchQuery'] = searchQuery;

      final products = await ProductRepository.instance
          .fetchCompareProductWithNameAndCategoryId(
              searchQuery, query, categoryId);
      return products;
    } catch (e) {
      ELoader.errorSnackBar(
          title: 'Opp! Something went wrong.', message: e.toString());
      return [];
    }
  }

  void sortProducts(String searchQuery, String sortOption, String categoryId) {
    selectedSortOption.value = sortOption;

    String sortBy = getSortByValue(sortOption);

    Map<String, dynamic> query = {
      'sortBy': sortBy,
      'page': '1',
      'pageSize': '10',
      'categories': categoryId,
    };

    getCompareProduct(searchQuery, query, categoryId).then((fetchedProducts) {
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

  void loadMoreProducts(String searchQuery, String categoryId) async {
    if (isLoading.value || !hasMoreData) return;

    isLoading.value = true;
    currentPage++;

    Map<String, dynamic> query = {
      'sortBy': getSortByValue(selectedSortOption.value),
      'page': '$currentPage',
      'pageSize': '10',
      'categories': categoryId,
    };

    final fetchedProducts =
        await getCompareProduct(searchQuery, query, categoryId);

    if (fetchedProducts.isNotEmpty) {
      products.addAll(fetchedProducts);
    } else {
      hasMoreData = false;
    }

    isLoading.value = false;
  }

  void assignProducts(List<ProductModel> newProducts) {
    products.assignAll(newProducts);
  }
}
