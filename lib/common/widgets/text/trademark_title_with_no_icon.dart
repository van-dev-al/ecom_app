import 'package:ecom_app/common/widgets/text/trademark_title_text.dart';
import 'package:ecom_app/utils/constaints/enums.dart';
import 'package:flutter/material.dart';

class ETrademarkTitleWithNoIcon extends StatelessWidget {
  const ETrademarkTitleWithNoIcon({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.textColor,
    this.textAlign = TextAlign.center,
    this.trademarkTextSizes = TextSizes.small,
  });

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
