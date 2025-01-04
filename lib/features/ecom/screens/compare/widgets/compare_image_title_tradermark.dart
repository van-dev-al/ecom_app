import 'package:flutter/material.dart';

import '../../../../../common/widgets/images/rounded_image.dart';
import '../../../../../common/widgets/text/product_title_text.dart';
import '../../../../../common/widgets/text/trademark_title_with_icon.dart';
import '../../../../../utils/constaints/sizes.dart';

class EItemCompareImageTitleTrademark extends StatelessWidget {
  const EItemCompareImageTitleTrademark({
    super.key,
    required this.title,
    required this.nameTrademark,
    required this.imageTrademark,
    required this.image,
  });

  final String title, nameTrademark, imageTrademark, image;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // image
        ERoundedImage(
          width: 100,
          isNetworkImage: true,
          imageUrl: image,
        ),
        const SizedBox(width: ESizes.spaceBtwItems),

        // title and trademark
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EProductTitleText(
                title: title,
                maxLines: 1,
              ),
              const SizedBox(height: ESizes.spaceBtwItems),
              ETrademarkTitleWithIcon(
                title: nameTrademark,
                image: imageTrademark,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
