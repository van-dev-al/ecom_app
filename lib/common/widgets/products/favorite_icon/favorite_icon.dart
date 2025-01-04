import 'package:ecom_app/common/widgets/icons/circular_icon.dart';
import 'package:ecom_app/features/ecom/controllers/products/favorite_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EFavoriteIcon extends StatelessWidget {
  const EFavoriteIcon({super.key, required this.productUrl});

  final String productUrl;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoriteController());
    return Obx(
      () => ECircularIcon(
        icon:
            controller.isFavorite(productUrl) ? Iconsax.heart5 : Iconsax.heart,
        color: controller.isFavorite(productUrl) ? Colors.red : null,
        onPressed: () => controller.toggleFavoriteProduct(productUrl),
      ),
    );
  }
}
