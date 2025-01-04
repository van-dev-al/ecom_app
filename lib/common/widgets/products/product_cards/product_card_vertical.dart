import 'package:ecom_app/common/styles/shadows.dart';
import 'package:ecom_app/common/widgets/images/rounded_image.dart';
import 'package:ecom_app/common/widgets/products/favorite_icon/favorite_icon.dart';
import 'package:ecom_app/common/widgets/text/product_title_text.dart';
import 'package:ecom_app/features/ecom/controllers/products/compare_controller.dart';
import 'package:ecom_app/features/ecom/models/products/product_model.dart';
import 'package:ecom_app/features/ecom/screens/product_detail/product_detail.dart';
import 'package:ecom_app/utils/constaints/colors.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:ecom_app/utils/helpers/helper_funtions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../custom_shapes/containers/rouded_container.dart';
import '../../text/product_price_text.dart';
import '../../text/trademark_title_with_icon.dart';

class EProductCardVertical extends StatelessWidget {
  const EProductCardVertical({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFuntions.isDarkMode(context);
    final controller = Get.put(CompareController());

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(ESizes.productImageRadius),
        onTap: () => Get.to(() => ProductDetailScreen(
              product: product,
            )),
        child: Container(
          width: 180,
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            boxShadow: [EShadowStyle.verticalProductShawdow],
            borderRadius: BorderRadius.circular(ESizes.productImageRadius),
            color: dark ? EColors.dark.withOpacity(0.6) : EColors.white,
          ),
          child: Column(
            children: [
              // thumbnail, favorites button, discount tag
              ERoundedContainer(
                height: 180,
                padding: const EdgeInsets.all(ESizes.md),
                backgroundColor: dark ? EColors.dark : EColors.light,
                child: Stack(
                  children: [
                    // thumbnail image
                    ERoundedImage(
                      imageUrl: product.thumbnail,
                      applyImageRadius: true,
                      isNetworkImage: true,
                    ),
                    // sale tag
                    Positioned(
                      top: 12,
                      child: ERoundedContainer(
                        radius: ESizes.sm,
                        backgroundColor: EColors.secondary.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: ESizes.sm, vertical: ESizes.xs),
                        child: Text('${product.discount.toStringAsFixed(0)}%',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .apply(color: EColors.black)),
                      ),
                    ),

                    // favorites button
                    Positioned(
                        top: 0,
                        right: 0,
                        child: EFavoriteIcon(productUrl: product.urls)),
                  ],
                ),
              ),
              const SizedBox(height: ESizes.spaceBtwItems / 2),
              // details
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: ESizes.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EProductTitleText(
                      title: product.name,
                      smallSize: true,
                    ),
                    const SizedBox(height: ESizes.spaceBtwItems / 2),
                    ETrademarkTitleWithIcon(
                      title: product.trademarkModel!.source,
                      image: product.trademarkModel!.image,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // price
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: ESizes.sm),
                      child: EProductPriceText(
                        price: product.price.toStringAsFixed(0),
                        isLarge: false,
                      ),
                    ),
                  ),

                  // add to compare button
                  InkWell(
                    onTap: () {
                      controller.addProductToCompare(product);
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: EColors.dark,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(ESizes.cardRadiusMd),
                          bottomRight:
                              Radius.circular(ESizes.productImageRadius),
                        ),
                      ),
                      child: const SizedBox(
                        width: ESizes.iconLg * 1.2,
                        height: ESizes.iconLg * 1.2,
                        child: Center(
                          child: Icon(
                            Iconsax.add,
                            color: EColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
