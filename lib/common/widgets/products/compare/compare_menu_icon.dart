import 'package:ecom_app/features/ecom/controllers/products/compare_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constaints/colors.dart';
import '../../../../utils/helpers/helper_funtions.dart';

class ECompareCounterIcon extends StatelessWidget {
  const ECompareCounterIcon({
    super.key,
    required this.onPressed,
    this.iconColor,
  });

  final Color? iconColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFuntions.isDarkMode(context);
    final controller = CompareController.instance;

    return Stack(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.compare_arrows),
          color: iconColor ?? (dark ? EColors.white : EColors.black),
        ),
        Obx(
          () => Positioned(
            right: 0,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: dark ? EColors.white : EColors.black,
              ),
              child: Center(
                child: Text(
                  controller.compareItems.length.toString(),
                  style: Theme.of(context).textTheme.labelLarge!.apply(
                      color: dark ? EColors.black : EColors.white,
                      fontSizeFactor: 0.8),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
