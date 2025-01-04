import 'package:ecom_app/features/ecom/models/products/product_model.dart';
import 'package:get/get.dart';

class CompareController extends GetxController {
  static CompareController get instance => Get.find();
  var compareItems = <ProductModel>[].obs;

  void addProductToCompare(ProductModel product) {
    if (compareItems.length < 2) {
      compareItems.add(product);
    } else {
      Get.snackbar('Stop add to Compare!', 'Danh sách so sánh đã đầy.');
    }
  }

  void removeProductFromCompare(ProductModel product) {
    compareItems.remove(product);
  }

  bool canCompare() {
    return compareItems.length == 2;
  }

  void resetCompare() {
    compareItems.clear();
  }
}
