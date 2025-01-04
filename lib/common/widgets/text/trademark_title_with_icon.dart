import 'package:ecom_app/common/widgets/images/rounded_image.dart';
import 'package:ecom_app/common/widgets/text/trademark_title_text.dart';
import 'package:ecom_app/utils/constaints/enums.dart';
import 'package:flutter/material.dart';

import '../../../utils/constaints/sizes.dart';

class ETrademarkTitleWithIcon extends StatelessWidget {
  const ETrademarkTitleWithIcon({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.textColor,
    this.textAlign = TextAlign.center,
    this.trademarkTextSizes = TextSizes.small,
    required this.image,
  });

  final String image;
  final String title;
  final int maxLines;
  final Color? textColor;
  final TextAlign? textAlign;
  final TextSizes trademarkTextSizes;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 18,
          height: 18,
          child: Center(
              child: ERoundedImage(
                  imageUrl: image,
                  isNetworkImage: true,
                  width: 32,
                  height: 32)),
        ),
        const SizedBox(width: ESizes.spaceBtwItems / 3),
        Flexible(
          child: ETrademarkTitleText(
            title: title,
            color: textColor,
            maxLines: maxLines,
            textAlign: textAlign,
            trademarkTextSizes: trademarkTextSizes,
          ),
        )
      ],
    );
  }
}
