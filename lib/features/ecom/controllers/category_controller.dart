import 'package:ecom_app/common/widgets/loaders/loaders.dart';
import 'package:ecom_app/data/repositories/categories/category_repository.dart';
import 'package:ecom_app/data/repositories/products/product_repository.dart';
import 'package:ecom_app/features/ecom/models/category_model.dart';
import 'package:ecom_app/features/ecom/models/products/product_model.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuresCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  // load categories data
  Future<void> fetchCategories() async {
    try {
      // show loader
      isLoading.value = true;

      final categories = await _categoryRepository.getAllCategories();
      allCategories.assignAll(categories);

      featuresCategories.assignAll(allCategories
          .where((category) => category.isFeatured && category.parentId.isEmpty)
          .take(4)
          .toList());
    } catch (e) {
      ELoader.errorSnackBar(
          title: 'Opp! Something bad happened.', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> getTrademarkCategoryProducts(
      {required String categoryId,
      int limit = 4,
      required Map<String, dynamic>? query}) async {
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
}
