import 'package:ecom_app/common/widgets/custom_shapes/containers/rouded_container.dart';
import 'package:ecom_app/common/widgets/text/product_price_text.dart';
import 'package:ecom_app/common/widgets/text/product_title_text.dart';
import 'package:ecom_app/common/widgets/text/trademark_title_with_icon.dart';
import 'package:ecom_app/common/widgets/text/trademark_title_with_no_icon.dart';
import 'package:ecom_app/features/ecom/models/products/product_model.dart';
import 'package:ecom_app/utils/constaints/colors.dart';
import 'package:ecom_app/utils/constaints/enums.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:ecom_app/utils/formatters/formatter.dart';
import 'package:flutter/material.dart';

class EProductMetaData extends StatelessWidget {
  const EProductMetaData({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    // final dark = EHelperFuntions.isDarkMode(context);

    final formattedPrice = EFormatter.formatCurrency(product.originalPrice);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            /// price and sale price
            ERoundedContainer(
              radius: ESizes.sm,
              backgroundColor: EColors.secondary.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: ESizes.sm, vertical: ESizes.xs),
              child: Text(
                '${product.discount.toStringAsFixed(0)}%',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: Colors.black),
              ),
            ),
            const SizedBox(width: ESizes.spaceBtwItems),
            EProductPriceText(
                price: product.price.toStringAsFixed(0), isLarge: true),
            const SizedBox(width: ESizes.spaceBtwItems / 1.5),
            Text(formattedPrice,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .apply(decoration: TextDecoration.lineThrough)),
          ],
        ),
        const SizedBox(height: ESizes.spaceBtwItems / 1.5),

        /// title
        EProductTitleText(title: product.name),
        const SizedBox(height: ESizes.spaceBtwItems),

        /// trademark and brand
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: ESizes.spaceBtwItems / 2),
              child: Text('Brand:'),
            ),
            ETrademarkTitleWithNoIcon(
              title: product.brand,
              trademarkTextSizes: TextSizes.medium,
            )
          ],
        ),
        const SizedBox(height: ESizes.spaceBtwItems / 1.5),
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: ESizes.spaceBtwItems / 2),
              child: Text('Sources:'),
            ),
            ETrademarkTitleWithIcon(
              title: product.trademarkModel!.source,
              trademarkTextSizes: TextSizes.medium,
              image: product.trademarkModel!.image,
            ),
          ],
        )
      ],
    );
  }
}
