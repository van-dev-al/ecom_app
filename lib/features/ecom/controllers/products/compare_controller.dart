import 'package:ecom_app/common/widgets/loaders/loaders.dart';
import 'package:ecom_app/features/ecom/models/products/product_model.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:ecom_app/utils/helpers/helper_funtions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompareController extends GetxController {
  static CompareController get instance => Get.find();
  var compareItems = <ProductModel>[].obs;

  void addProductToCompare(ProductModel product) {
    String getCategoryName(String categoryId) {
      switch (categoryId) {
        case 'mobiles':
          return 'Mobile';
        case 'tablets':
          return 'Tablet';
        case 'laptops':
          return 'Laptop';
        default:
          return 'Danh mục khác';
      }
    }

    if (compareItems.any((item) => item.urls == product.urls)) {
      Get.snackbar(
        'Sản phẩm đã có trong danh sách so sánh',
        'Bạn không thể thêm sản phẩm này nữa.',
      );
      return;
    }

    if (compareItems.isNotEmpty &&
        compareItems.first.categoryId != product.categoryId &&
        compareItems.length < 2) {
      String currentCategoryName =
          getCategoryName(compareItems.first.categoryId);
      Get.snackbar(
        'Sản phẩm không thuộc cùng danh mục',
        'Bạn chỉ có thể so sánh sản phẩm trong cùng một danh mục.\n'
            'Hiện bạn đang so sánh sản phẩm với danh mục: $currentCategoryName.',
      );
      return;
    }

    if (compareItems.length < 2) {
      compareItems.add(product);
      ELoader.customToast(
          message: 'Add product to Compare specifications successfully!');
    } else {
      String currentCategoryName =
          getCategoryName(compareItems.first.categoryId);
      showReplaceDialog(product, currentCategoryName);
    }
  }

  void showReplaceDialog(ProductModel product, String currentCategoryName) {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(ESizes.md),
      title: 'Compare specifications list is FULL!',
      middleText: 'You are compare with categories: $currentCategoryName.\n'
          'Do you want to clear all list?',
      backgroundColor: EHelperFuntions.isDarkMode(Get.context!)
          ? Colors.lightBlue[900]
          : Colors.white,
      confirm: ElevatedButton(
          onPressed: () {
            resetCompare();
            compareItems.add(product);
            Get.back();
            Get.snackbar(
              'Thêm sản phẩm thành công',
              'Làm mới danh sách so sánh. Sản phẩm mới đã được thêm vào.',
            );
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: ESizes.lg),
            child: Text('Clear'),
          )),
      cancel: OutlinedButton(
          onPressed: () {
            Get.back();
          },
          child: Text('Cancel')),
    );
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
