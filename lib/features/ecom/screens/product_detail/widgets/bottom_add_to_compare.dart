import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:ecom_app/utils/helpers/helper_funtions.dart';
import 'package:flutter/material.dart';

class EBottomAddToCompare extends StatelessWidget {
  const EBottomAddToCompare({
    super.key,
    required this.onPressed,
    required this.label,
    this.padding = 0,
  });

  final VoidCallback onPressed;
  final String label;
  final double padding;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFuntions.isDarkMode(context);

    return Padding(
      padding: EdgeInsets.only(
          right: ESizes.defaultSpace,
          left: ESizes.defaultSpace,
          bottom: padding),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: onPressed,
          // icon: const Icon(Icons.compare_arrows),
          label: Text(label),
          style: ElevatedButton.styleFrom(
            side: BorderSide.none,
            padding: const EdgeInsets.symmetric(
                vertical: ESizes.defaultSpace / 1.5,
                horizontal: ESizes.defaultSpace),
            backgroundColor: dark
                ? const Color.fromARGB(255, 15, 102, 20)
                : Colors.green[700],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 5,
          ),
        ),
      ),
    );
  }
}
