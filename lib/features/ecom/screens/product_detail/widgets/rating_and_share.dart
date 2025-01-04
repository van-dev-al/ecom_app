import 'package:ecom_app/features/ecom/models/products/product_model.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

class ERatingAndShare extends StatelessWidget {
  const ERatingAndShare({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // rating
      children: [
        Row(
          children: [
            const Icon(Iconsax.star5, color: Colors.amber, size: 24),
            const SizedBox(width: ESizes.spaceBtwItems / 2),
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: '${product.ratingAverage}',
                  style: Theme.of(context).textTheme.bodyLarge),
              TextSpan(text: '(${product.reviewCount})')
            ]))
          ],
        ),
        // share button
        IconButton(
          onPressed: () async {
            await _copyUrlToClipboard(context);
          },
          icon: const Icon(Icons.share, size: ESizes.iconMd),
        )
      ],
    );
  }

  Future<void> _copyUrlToClipboard(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: product.urls));
  }
}
