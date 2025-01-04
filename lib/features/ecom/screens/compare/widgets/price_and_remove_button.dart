import 'package:ecom_app/utils/helpers/helper_funtions.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/text/product_price_text.dart';
import '../../../../../utils/constaints/sizes.dart';

class EItemComparePriceAndRemoveButton extends StatelessWidget {
  const EItemComparePriceAndRemoveButton({
    super.key,
    required this.price,
    this.btnName = 'Remove',
    required this.onPressed,
  });

  final String price, btnName;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFuntions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: ESizes.md),
          child: EProductPriceText(price: price),
        ),
        ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              side: BorderSide.none,
              backgroundColor: dark ? Colors.red[900] : Colors.red[700],
            ),
            child: Text(
              btnName,
            ))
      ],
    );
  }
}
