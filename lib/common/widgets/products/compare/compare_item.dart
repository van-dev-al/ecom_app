import 'package:ecom_app/common/widgets/custom_shapes/containers/rouded_container.dart';
import 'package:ecom_app/features/ecom/controllers/products/compare_controller.dart';
import 'package:ecom_app/features/ecom/models/products/product_model.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constaints/colors.dart';
import '../../../../utils/constaints/sizes.dart';
import '../../../../utils/helpers/helper_funtions.dart';
import '../../../../features/ecom/screens/compare/widgets/compare_image_title_tradermark.dart';
import '../../../../features/ecom/screens/compare/widgets/price_and_remove_button.dart';

class ECompareItem extends StatelessWidget {
  const ECompareItem({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFuntions.isDarkMode(context);
    final controller = CompareController.instance;

    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        border: Border.all(
            color: dark
                ? EColors.light.withOpacity(0.6)
                : EColors.dark.withOpacity(0.6)),
        borderRadius: BorderRadius.circular(ESizes.productImageRadius),
        color: dark ? EColors.black : EColors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: ERoundedContainer(
              width: EHelperFuntions.screenWidth(),
              padding: const EdgeInsets.all(ESizes.md),
              backgroundColor:
                  dark ? EColors.dark.withOpacity(0.6) : EColors.light,
              child: Padding(
                padding: const EdgeInsets.only(top: ESizes.sm),
                child: Column(
                  children: [
                    // image, title and trademark
                    EItemCompareImageTitleTrademark(
                      title: product.name,
                      nameTrademark: product.trademarkModel!.source,
                      image: product.thumbnail,
                      imageTrademark: product.trademarkModel!.image,
                    ),
                    const SizedBox(height: ESizes.spaceBtwItems),
                    EItemComparePriceAndRemoveButton(
                        price: product.price.toString(),
                        onPressed: () {
                          controller.removeProductFromCompare(product);
                        }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
