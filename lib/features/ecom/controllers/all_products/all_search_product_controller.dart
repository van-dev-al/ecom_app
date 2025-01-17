import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/common/widgets/loaders/loaders.dart';
import 'package:ecom_app/data/repositories/authentication/authentication_repositories.dart';
import 'package:ecom_app/data/repositories/products/product_repository.dart';
import 'package:ecom_app/features/ecom/models/products/product_model.dart';
import 'package:get/get.dart';

class AllSearchController extends GetxController {
  static AllSearchController get instance => Get.find();

  final repository = ProductRepository.instance;
  final RxString selectedSortOption = ''.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;

  Future<List<ProductModel>> fetchProductsBySearchQuery(String keyWord) async {
    try {
      Map<String, dynamic> query = {
        'categories': '',
        'sortBy': '',
        'page': '',
        'pageSize': '',
        'searchNameQuery': keyWord
      };
      final products = await repository.searchProducts(keyWord, query);
      assignProducts(products);

      await toggleSearchHistory(keyWord);

      return products;
    } catch (e) {
      ELoader.errorSnackBar(
          title: 'Oops! Something went wrong.', message: e.toString());
      return [];
    }
  }

  // Assign products to the list and then sort them by the default option (Name)
  void assignProducts(List<ProductModel> newProducts) {
    products.assignAll(newProducts);
    sortProducts('');
  }

  // Sort the products based on the selected option
  void sortProducts(String sortOption) {
    selectedSortOption.value = sortOption;

    switch (sortOption) {
      case 'Name':
        products.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'Higher Price':
        products.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Lower Price':
        products.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Discount':
        products.sort((a, b) => b.discount.compareTo(a.discount));
        break;
      case 'Reviews':
        products.sort((a, b) => b.reviewCount.compareTo(a.reviewCount));
        break;
      default:
        products.sort((a, b) => a.name.compareTo(b.name));
    }
  }

  // Save search history
  Future<void> toggleSearchHistory(String query) async {
    String userId = AuthenticationRepositories.instance.authUser?.uid ?? "/";
    try {
      await FirebaseFirestore.instance
          .collection('SearchHistory')
          .doc(userId)
          .collection('history')
          .add({
        'query': query,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw e.toString();
    }
  }
}
