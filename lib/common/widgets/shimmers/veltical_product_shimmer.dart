import 'package:ecom_app/common/widgets/layouts/grid_layout.dart';
import 'package:ecom_app/common/widgets/shimmers/shimmer.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:flutter/material.dart';

class EVelticalProductShimmer extends StatelessWidget {
  const EVelticalProductShimmer({
    super.key,
    this.itemCount = 4,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return EGridLayout(
      itemCount: itemCount,
      itemBuilder: (_, __) => const SizedBox(
        width: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //image
            EShimmerEffect(width: 180, height: 180),
            SizedBox(height: ESizes.spaceBtwItems),

            //text
            EShimmerEffect(width: 160, height: 15),
            SizedBox(height: ESizes.spaceBtwItems / 2),
            EShimmerEffect(width: 110, height: 15),
          ],
        ),
      ),
    );
  }
}
