import 'package:ecom_app/utils/helpers/helper_funtions.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constaints/image_string.dart';
import '../../../../../utils/constaints/sizes.dart';
import '../../../../../utils/constaints/text_string.dart';

class ELoginHeader extends StatelessWidget {
  const ELoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFuntions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          height: 150,
          image: AssetImage(dark ? EImages.appLogo : EImages.appLogoDark),
        ),
        const SizedBox(
          height: ESizes.spaceBtwItems / 2,
        ),
        Text(
          ETexts.loginTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: ESizes.sm),
        Text(
          ETexts.loginSubTitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
