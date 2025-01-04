import 'package:ecom_app/common/widgets/custom_shapes/containers/rouded_container.dart';
import 'package:ecom_app/common/widgets/images/rounded_image.dart';
import 'package:ecom_app/common/widgets/products/favorite_icon/favorite_icon.dart';
import 'package:ecom_app/common/widgets/text/product_price_text.dart';
import 'package:ecom_app/common/widgets/text/product_title_text.dart';
import 'package:ecom_app/common/widgets/text/trademark_title_with_icon.dart';
import 'package:ecom_app/features/ecom/models/products/product_model.dart';
import 'package:ecom_app/features/ecom/screens/product_detail/product_detail.dart';
import 'package:ecom_app/utils/constaints/colors.dart';
import 'package:ecom_app/utils/constaints/image_string.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:ecom_app/utils/helpers/helper_funtions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EProductCardHorizontal extends StatelessWidget {
  const EProductCardHorizontal({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFuntions.isDarkMode(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(ESizes.productImageRadius),
        onTap: () => Get.to(() => ProductDetailScreen(product: product)),
        child: IntrinsicWidth(
          child: Container(
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ESizes.productImageRadius),
              color: dark ? EColors.darkGrey : EColors.softGrey,
            ),
            child: Row(
              children: [
                // thumbnails
                ERoundedContainer(
                  height: 120,
                  // padding: const EdgeInsets.all(ESizes.sm),
                  backgroundColor: dark ? EColors.dark : EColors.light,
                  child: Stack(
                    children: [
                      // thumbnail image
                      const SizedBox(
                        width: 120,
                        height: 120,
                        child: ERoundedImage(
                            imageUrl: EImages.productImage1,
                            applyImageRadius: true),
                      ),

                      // sale tag
                      Positioned(
                        top: 10,
                        child: ERoundedContainer(
                          radius: ESizes.sm,
                          backgroundColor: EColors.secondary.withOpacity(0.8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: ESizes.sm, vertical: ESizes.xs),
                          child: Text('99%',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .apply(color: EColors.black)),
                        ),
                      ),

                      // favorites button
                      const Positioned(
                          top: 5,
                          right: 0,
                          child: EFavoriteIcon(productUrl: '')),
                    ],
                  ),
                ),
                // detail
                SizedBox(
                  width: 172,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: ESizes.sm, left: ESizes.sm),
                    child: Column(
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            EProductTitleText(
                                title:
                                    'Samsung Galazy s24 Ultra ahaahshdadasdasghd',
                                smallSize: true),
                            SizedBox(height: ESizes.spaceBtwItems / 2),
                            ETrademarkTitleWithIcon(
                              title: 'tiki.vn',
                              image: '',
                            )
                          ],
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // price
                            const Flexible(
                                child: EProductPriceText(
                                    price: '999.999.999.999.999')),

                            // add to compare button
                            Container(
                              decoration: const BoxDecoration(
                                color: EColors.dark,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(ESizes.cardRadiusMd),
                                  bottomRight: Radius.circular(
                                      ESizes.productImageRadius),
                                ),
                              ),
                              child: const SizedBox(
                                width: ESizes.iconLg * 1.1,
                                height: ESizes.iconLg * 1.1,
                                child: Center(
                                  child: Icon(
                                    Iconsax.add,
                                    color: EColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
