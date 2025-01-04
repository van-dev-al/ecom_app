import 'package:ecom_app/common/widgets/shimmers/shimmer.dart';
import 'package:flutter/material.dart';

import '../../../utils/constaints/colors.dart';
import '../../../utils/constaints/sizes.dart';

class ERoundedImage extends StatelessWidget {
  const ERoundedImage({
    super.key,
    this.width,
    this.height,
    required this.imageUrl,
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor = EColors.light,
    this.fit = BoxFit.cover,
    this.padding,
    this.isNetworkImage = false,
    this.onPressed,
    this.borderRadius = ESizes.md,
  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: isNetworkImage
              ? Image.network(
                  imageUrl,
                  fit: fit,
                  width: width,
                  height: height,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return EShimmerEffect(
                        width: width ?? double.infinity,
                        height: height ?? double.infinity,
                        radius: borderRadius,
                      );
                    }
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.store,
                        color: EColors.error,
                        size: 20,
                      ),
                    );
                    // return EShimmerEffect(
                    //   width: width ?? double.infinity,
                    //   height: height ?? double.infinity,
                    //   radius: borderRadius,
                    // );
                  },
                )
              : Image.asset(
                  imageUrl,
                  fit: fit,
                  width: width,
                  height: height,
                ),
        ),
      ),
    );
  }
}
