import 'package:ecom_app/utils/constaints/colors.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:ecom_app/utils/helpers/helper_funtions.dart';
import 'package:flutter/material.dart';

class ECircularIcon extends StatelessWidget {
  const ECircularIcon({
    super.key,
    this.width,
    this.height,
    this.size = ESizes.lg,
    required this.icon,
    this.color,
    this.backgroundColor,
    this.onPressed,
  });

  final double? width, height, size;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFuntions.isDarkMode(context);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor != null
            ? backgroundColor!
            : dark
                ? Colors.black.withOpacity(0.8)
                : EColors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: color,
          size: size,
        ),
      ),
    );
  }
}
