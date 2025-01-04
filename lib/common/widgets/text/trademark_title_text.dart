import 'package:ecom_app/utils/constaints/enums.dart';
import 'package:flutter/material.dart';

class ETrademarkTitleText extends StatelessWidget {
  const ETrademarkTitleText({
    super.key,
    required this.title,
    this.color,
    this.maxLines = 1,
    this.textAlign = TextAlign.center,
    this.trademarkTextSizes = TextSizes.small,
  });

  final String title;
  final Color? color;
  final int maxLines;
  final TextAlign? textAlign;
  final TextSizes trademarkTextSizes;

  @override
  Widget build(BuildContext context) {
    return Text(title,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        // check which trademark is required and set that style
        style: trademarkTextSizes == TextSizes.small
            ? Theme.of(context).textTheme.labelMedium!.apply(color: color)
            : trademarkTextSizes == TextSizes.medium
                ? Theme.of(context).textTheme.bodyLarge!.apply(color: color)
                : trademarkTextSizes == TextSizes.large
                    ? Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .apply(color: color)
                    : Theme.of(context).textTheme.bodyMedium!.apply(
                        color: color) // default to large if none specified,
        );
  }
}
