import 'package:ecom_app/common/widgets/images/circular_image.dart';
import 'package:flutter/material.dart';

import '../../../utils/constaints/colors.dart';
import '../../../utils/constaints/sizes.dart';
import '../../../utils/helpers/helper_funtions.dart';

class EHorizontalImageText extends StatelessWidget {
  const EHorizontalImageText({
    super.key,
    required this.image,
    required this.title,
    this.backgroundColor = EColors.white,
    this.onTap,
    this.isNetwordImage = true,
    this.width,
    this.height,
  });

  final String image, title;
  final Color? backgroundColor;
  final bool isNetwordImage;
  final void Function()? onTap;
  final double? width, height;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFuntions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: ESizes.spaceBtwItems / 2),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: dark ? EColors.black : (backgroundColor ?? EColors.white),
              borderRadius: BorderRadius.circular(100)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // circular icon
              ECircularImage(
                width: 40,
                image: image,
                isNetworkImage: isNetwordImage,
                borderRadius: 100,
                fit: BoxFit.cover,
                overlayColor: EHelperFuntions.isDarkMode(context)
                    ? EColors.light
                    : EColors.dark,
              ),
              const SizedBox(height: ESizes.spaceBtwSeccions / 2),
              Flexible(
                child: Text(
                  maxLines: 1,
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .apply(color: dark ? EColors.white : EColors.black),
                ),
              ),
              const SizedBox(width: ESizes.spaceBtwItems)
            ],
          ),
        ),
      ),
    );
  }
}
