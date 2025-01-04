import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_app/common/widgets/products/favorite_icon/favorite_icon.dart';
import 'package:ecom_app/features/ecom/models/products/product_model.dart';
import 'package:ecom_app/utils/helpers/helper_funtions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../../common/widgets/images/rounded_image.dart';
import '../../../../../utils/constaints/colors.dart';
import '../../../../../utils/constaints/sizes.dart';
import '../../../controllers/products/image_controller.dart';

class EProductImageSlider extends StatelessWidget {
  const EProductImageSlider({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFuntions.isDarkMode(context);

    final controller = Get.put(ImageController());
    final images = controller.getAllProductImage(product);

    return ECurvedEdgeWidget(
      child: Container(
        color: dark ? EColors.dark : EColors.white,
        child: Stack(
          children: [
            // main large image --------------------------------
            SizedBox(
              height: 410,
              child: Padding(
                padding: const EdgeInsets.only(top: ESizes.defaultSpace),
                child: Center(
                  child: Obx(() {
                    final image = controller.selectedProductImage.value;
                    return GestureDetector(
                      onTap: () => controller.showLargeImage(image),
                      child: CachedNetworkImage(
                        imageUrl: image,
                        progressIndicatorBuilder: (_, __, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress,
                                color: EColors.primary),
                      ),
                    );
                  }),
                ),
              ),
            ),
            // image slider --------------------------------
            Positioned(
              right: 0,
              bottom: 30,
              left: ESizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  itemCount: images.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: ESizes.spaceBtwItems),
                  itemBuilder: (_, index) => Obx(() {
                    final imageSelected =
                        controller.selectedProductImage.value == images[index];
                    return ERoundedImage(
                      width: 80,
                      isNetworkImage: true,
                      onPressed: () {
                        controller.selectedProductImage.value = images[index];
                      },
                      border: Border.all(
                          color: imageSelected
                              ? EColors.primary
                              : Colors.transparent),
                      backgroundColor: dark ? EColors.darkGrey : EColors.white,
                      imageUrl: images[index],
                    );
                  }),
                ),
              ),
            ),

            // appbar
            EAppBar(
              showBackArrow: true,
              backArrowColor: Colors.black,
              actions: [EFavoriteIcon(productUrl: product.urls)],
            )
          ],
        ),
      ),
    );
  }
}
