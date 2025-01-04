import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_app/features/ecom/models/products/product_model.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageController extends GetxController {
  static ImageController get instance => Get.find();

  RxString selectedProductImage = ''.obs;

  // Hàm để xử lý chuỗi URL thành list
  List<String> _parseImageUrls(String urls) {
    if (urls.isEmpty) return [];
    // Tách chuỗi thành list dựa trên dấu phẩy và loại bỏ khoảng trắng
    return urls
        .split(',')
        .map((url) => url.trim())
        .where((url) => url.isNotEmpty)
        .toList();
  }

  List<String> getAllProductImage(ProductModel product) {
    Set<String> images = {};

    // Xử lý thumbnail
    if (product.thumbnail.isNotEmpty) {
      // Kiểm tra xem thumbnail có chứa nhiều URL không
      if (product.thumbnail.contains(',')) {
        var thumbnailUrls = _parseImageUrls(product.thumbnail);
        if (thumbnailUrls.isNotEmpty) {
          images.add(thumbnailUrls.first);
          selectedProductImage.value = thumbnailUrls.first;
        }
      } else {
        images.add(product.thumbnail);
        selectedProductImage.value = product.thumbnail;
      }
    }

    if (product.imageUrls is String) {
      images.addAll(_parseImageUrls(product.imageUrls as String));
    }

    images.addAll((product.imageUrls as List)
        .where((url) => url != null && url.toString().isNotEmpty)
        .map((url) => url.toString()));

    return images.toList();
  }

  void showLargeImage(String imageUrl) {
    if (imageUrl.isEmpty) return;

    Get.to(
      fullscreenDialog: true,
      () => Dialog.fullscreen(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: ESizes.defaultSpace * 2,
                horizontal: ESizes.defaultSpace,
              ),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(Icons.error_outline, size: 50),
                ),
                fit: BoxFit.contain,
                fadeInDuration: const Duration(milliseconds: 300),
              ),
            ),
            const SizedBox(height: ESizes.spaceBtwSeccions),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 150,
                child: OutlinedButton(
                  onPressed: () => Get.back(),
                  child: const Text('Close'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
