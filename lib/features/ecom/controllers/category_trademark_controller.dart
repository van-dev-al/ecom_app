import 'package:ecom_app/common/widgets/loaders/loaders.dart';
import 'package:ecom_app/data/repositories/products/product_repository.dart';
import 'package:ecom_app/data/repositories/tradematk/trademark_repository.dart';
import 'package:ecom_app/features/ecom/models/products/product_model.dart';
import 'package:ecom_app/features/ecom/models/trademark_model.dart';
import 'package:get/get.dart';

class CategoryTrademarkController extends GetxController {
  static CategoryTrademarkController get instance => Get.find();

  final RxBool isLoading = false.obs;
  final RxList<TrademarkModel> fearturedTrademark = <TrademarkModel>[].obs;
  final RxList<TrademarkModel> allTrademark = <TrademarkModel>[].obs;
  final trademarkRepository = Get.put(TrademarkRepository());

  final RxString selectedSortOption = ''.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;
  int currentPage = 1;
  bool hasMoreData = true;

  @override
  void onInit() {
    super.onInit();
    getFeaturedTrademark();
  }

  Future<void> getFeaturedTrademark() async {
    try {
      isLoading.value = true;

      final trademarks = await trademarkRepository.getAllTrademarks();

      allTrademark.assignAll(trademarks);

      fearturedTrademark.assignAll(allTrademark
          .where((trademark) => trademark.isFeatured ?? false)
          .take(3));
    } catch (e) {
      ELoader.errorSnackBar(
          title: 'Opp! Something went wrong.', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<TrademarkModel>> getTrademarksForCategory(
      String categoryId) async {
    try {
      final trademarks =
          await trademarkRepository.getTrademarksForCategory(categoryId);
      return trademarks;
    } catch (e) {
      ELoader.errorSnackBar(
          title: 'Opp! Something went wrong.', message: e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getTrademarkProducts(
      String source, Map<String, dynamic> query, String categoryId) async {
    try {
      query['source'] = source;

      final products = await ProductRepository.instance
          .fetchProductsForSorceAndCategoryTrademark(source, query, categoryId);
      return products;
    } catch (e) {
      ELoader.errorSnackBar(
          title: 'Opp! Something went wrong.', message: e.toString());
      return [];
    }
  }

  void sortProducts(String source, String sortOption, String categoryId) {
    selectedSortOption.value = sortOption;

    String sortBy = getSortByValue(sortOption);

    Map<String, dynamic> query = {
      'sortBy': sortBy,
      'page': '1',
      'pageSize': '10',
      'categories': categoryId,
    };

    getTrademarkProducts(source, query, categoryId).then((fetchedProducts) {
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

  void loadMoreProducts(String source, String categoryId) async {
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
        await getTrademarkProducts(source, query, categoryId);

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
