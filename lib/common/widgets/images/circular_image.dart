import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom_app/common/widgets/shimmers/shimmer.dart';
import 'package:ecom_app/utils/constaints/colors.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:ecom_app/utils/helpers/helper_funtions.dart';
import 'package:flutter/material.dart';

class ECircularImage extends StatelessWidget {
  const ECircularImage({
    super.key,
    this.fit = BoxFit.cover,
    required this.image,
    this.isNetworkImage = false,
    this.overlayColor,
    this.backgroundColor,
    this.width = 56,
    this.height = 56,
    this.padding = ESizes.sm,
    this.borderRadius = 0,
  });

  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double borderRadius;
  final double width, height, padding;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFuntions.isDarkMode(context);
    return Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: backgroundColor ?? (dark ? EColors.black : EColors.white),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: isNetworkImage
              ? CachedNetworkImage(
                  imageUrl: image,
                  fit: fit,
                  color: overlayColor,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      const EShimmerEffect(width: 40, height: 40, radius: 100),
                  errorWidget: (context, url, error) =>
                      const EShimmerEffect(width: 40, height: 40, radius: 100),
                )
              : Image.asset(
                  image,
                  fit: fit,
                  color: overlayColor,
                ),
        ));
  }
}
