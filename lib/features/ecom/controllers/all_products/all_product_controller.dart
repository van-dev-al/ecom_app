import 'package:ecom_app/common/widgets/loaders/loaders.dart';
import 'package:ecom_app/data/repositories/products/product_repository.dart';
import 'package:ecom_app/features/ecom/models/products/product_model.dart';
import 'package:get/get.dart';

class AllProductController extends GetxController {
  static AllProductController get instance => Get.find();

  final repository = ProductRepository.instance;
  final RxString selectedSortOption = ''.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;

  final RxBool isLoadingMore = false.obs;
  int currentPage = 1;
  bool hasMoreData = true;

  Future<List<ProductModel>> fetchProductsByQuery(
      Map<String, dynamic>? query) async {
    try {
      if (query == null) return [];
      final products = await repository.fetchQueryProducts(query);

      return products;
    } catch (e) {
      ELoader.errorSnackBar(
          title: 'Opp! Something went wrong.', message: e.toString());
      return [];
    }
  }

  void sortProducts(String sortOption) {
    selectedSortOption.value = sortOption;

    String sortBy = getSortByValue(sortOption);

    Map<String, dynamic> query = {
      'sortBy': sortBy,
      'page': '1',
      'pageSize': '10',
    };

    fetchProductsByQuery(query).then((fetchedProducts) {
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

  void loadMoreProducts() async {
    if (isLoadingMore.value || !hasMoreData) return;

    isLoadingMore.value = true;
    currentPage++;

    Map<String, dynamic> query = {
      'sortBy': getSortByValue(selectedSortOption.value),
      'page': '$currentPage',
      'pageSize': '10',
    };

    final fetchedProducts = await fetchProductsByQuery(query);

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
