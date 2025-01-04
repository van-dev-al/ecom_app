import 'package:ecom_app/common/widgets/images/circular_image.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/text/product_title_text.dart';
import '../../../../../common/widgets/text/trademark_title_with_no_icon.dart';
import '../../../../../utils/constaints/sizes.dart';

class EItemImageAuthorAndDescription extends StatelessWidget {
  const EItemImageAuthorAndDescription({
    super.key,
    this.author = 'admin',
    required this.description,
    required this.imageNew,
    required this.title,
  });

  final String author, description, title;
  final String imageNew;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ECircularImage(
          width: 80,
          isNetworkImage: true,
          image: imageNew,
        ),
        const SizedBox(width: ESizes.spaceBtwItems),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ETrademarkTitleWithNoIcon(title: 'author: $author'),
              const SizedBox(height: ESizes.spaceBtwItems / 2),
              EProductTitleText(
                title: title,
                maxLines: 2,
              ),
              const SizedBox(height: ESizes.spaceBtwItems / 2),
              ETrademarkTitleWithNoIcon(
                  title: description, maxLines: 3, textAlign: TextAlign.start),
            ],
          ),
        )
      ],
    );
  }
}
