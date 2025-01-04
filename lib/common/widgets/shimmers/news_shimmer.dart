import 'package:ecom_app/common/widgets/shimmers/shimmer.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:flutter/material.dart';

class ENewsShimmer extends StatelessWidget {
  const ENewsShimmer({
    super.key,
    this.itemCount = 6,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            EShimmerEffect(width: 120, height: 100, radius: 20),
            SizedBox(width: ESizes.spaceBtwItems),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EShimmerEffect(width: 100, height: 15),
                SizedBox(height: ESizes.spaceBtwItems / 2),
                EShimmerEffect(width: 160, height: 50)
              ],
            )
          ],
        ),
        SizedBox(height: ESizes.spaceBtwSeccions),
        Row(
          children: [
            EShimmerEffect(width: 120, height: 100, radius: 20),
            SizedBox(width: ESizes.spaceBtwItems),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EShimmerEffect(width: 100, height: 15),
                SizedBox(height: ESizes.spaceBtwItems / 2),
                EShimmerEffect(width: 160, height: 50)
              ],
            )
          ],
        ),
        SizedBox(height: ESizes.spaceBtwSeccions),
        Row(
          children: [
            EShimmerEffect(width: 120, height: 100, radius: 20),
            SizedBox(width: ESizes.spaceBtwItems),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EShimmerEffect(width: 100, height: 15),
                SizedBox(height: ESizes.spaceBtwItems / 2),
                EShimmerEffect(width: 160, height: 50)
              ],
            )
          ],
        ),
        SizedBox(height: ESizes.spaceBtwSeccions),
        Row(
          children: [
            EShimmerEffect(width: 120, height: 100, radius: 20),
            SizedBox(width: ESizes.spaceBtwItems),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EShimmerEffect(width: 100, height: 15),
                SizedBox(height: ESizes.spaceBtwItems / 2),
                EShimmerEffect(width: 160, height: 50)
              ],
            )
          ],
        )
      ],
    );
  }
}
