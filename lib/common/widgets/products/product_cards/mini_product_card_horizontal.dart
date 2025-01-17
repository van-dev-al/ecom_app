import 'package:ecom_app/common/styles/shadows.dart';
import 'package:ecom_app/common/widgets/custom_shapes/containers/rouded_container.dart';
import 'package:ecom_app/common/widgets/images/rounded_image.dart';
import 'package:ecom_app/common/widgets/text/product_price_text.dart';
import 'package:ecom_app/common/widgets/text/product_title_text.dart';
import 'package:ecom_app/common/widgets/text/trademark_title_with_icon.dart';
import 'package:ecom_app/features/ecom/models/products/product_model.dart';
import 'package:ecom_app/features/ecom/screens/product_detail/product_detail.dart';
import 'package:ecom_app/utils/constaints/colors.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:ecom_app/utils/device/device_utility.dart';
import 'package:ecom_app/utils/helpers/helper_funtions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class EMiniProductCardHorizontal extends StatelessWidget {
  const EMiniProductCardHorizontal({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFuntions.isDarkMode(context);

    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.only(top: ESizes.spaceBtwItems / 2),
        child: InkWell(
          borderRadius: BorderRadius.circular(ESizes.productImageRadius),
          onTap: () => Get.to(() => ProductDetailScreen(product: product)),
          child: Container(
            width: EDeviceUtils.getScreenWidth(context),
            constraints: BoxConstraints(maxHeight: 90),
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              boxShadow: [EShadowStyle.verticalProductShawdow],
              borderRadius: BorderRadius.circular(ESizes.productImageRadius),
              color: dark ? EColors.dark.withOpacity(0.6) : EColors.white,
            ),
            child: Row(
              children: [
                // thumbnails
                ERoundedContainer(
                  height: 80,
                  // padding: const EdgeInsets.all(ESizes.sm),
                  backgroundColor: dark ? EColors.dark : EColors.light,
                  child: Stack(
                    children: [
                      // thumbnail image
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: ERoundedImage(
                          fit: BoxFit.contain,
                          imageUrl: product.thumbnail,
                          applyImageRadius: true,
                          isNetworkImage: true,
                        ),
                      ),

                      // sale tag
                      Positioned(
                        top: 10,
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
                    ],
                  ),
                ),
                // detail
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: ESizes.sm, left: ESizes.md, right: ESizes.sm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            EProductTitleText(
                              title: product.name,
                              smallSize: true,
                              maxLines: 1,
                            ),
                            SizedBox(height: ESizes.spaceBtwItems / 2),
                            ETrademarkTitleWithIcon(
                              title: product.trademarkModel!.source,
                              image: product.trademarkModel!.image,
                            )
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
                            padding: EdgeInsets.only(left: ESizes.md),
                            child: EProductPriceText(
                                price: product.price.toStringAsFixed(0)),
                          )),
                          InkWell(
                            onTap: () {
                              final uri = Uri.parse(product.urls);
                              launchUrl(uri,
                                  mode: LaunchMode.externalApplication);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: dark
                                    ? EColors.primary.withOpacity(0.8)
                                    : EColors.dark,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(ESizes.cardRadiusMd),
                                  bottomRight: Radius.circular(
                                      ESizes.productImageRadius),
                                ),
                              ),
                              child: SizedBox(
                                height: ESizes.iconLg * 0.9,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: ESizes.sm, right: ESizes.sm),
                                      child: Text('Check out',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .apply(color: EColors.white)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
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
