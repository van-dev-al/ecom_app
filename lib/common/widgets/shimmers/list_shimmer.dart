import 'package:ecom_app/common/widgets/shimmers/shimmer.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:flutter/material.dart';

class EListShimmer extends StatelessWidget {
  const EListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            EShimmerEffect(width: 50, height: 50, radius: 20),
            SizedBox(width: ESizes.spaceBtwItems),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EShimmerEffect(width: 80, height: 15),
                SizedBox(height: ESizes.spaceBtwItems / 2),
                EShimmerEffect(width: 120, height: 12)
              ],
            )
          ],
        )
      ],
    );
  }
}
