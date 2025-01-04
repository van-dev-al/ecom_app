import 'package:ecom_app/utils/formatters/formatter.dart';
import 'package:flutter/material.dart';

class EProductPriceText extends StatelessWidget {
  const EProductPriceText({
    super.key,
    required this.price,
    this.maxLines = 1,
    this.isLarge = false,
    this.lineThrough = false,
  });

  final String price;
  final int maxLines;
  final bool isLarge;
  final bool lineThrough;

  @override
  Widget build(BuildContext context) {
    final double parsedPrice =
        double.tryParse(price.replaceAll(',', '')) ?? 0.0;

    final formattedPrice = EFormatter.formatCurrency(parsedPrice);
    return Text(
      formattedPrice,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: isLarge
          ? Theme.of(context).textTheme.headlineMedium!.apply(
              decoration: lineThrough ? TextDecoration.lineThrough : null)
          : Theme.of(context).textTheme.titleLarge!.apply(
              decoration: lineThrough ? TextDecoration.lineThrough : null),
    );
  }
}
