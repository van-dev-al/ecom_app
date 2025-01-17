import 'package:ecom_app/common/widgets/shimmers/shimmer.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:flutter/material.dart';

class EMiniHorizontalProductShimmer extends StatelessWidget {
  const EMiniHorizontalProductShimmer({
    super.key,
    this.itemCount = 5,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: ESizes.spaceBtwItems / 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shimmer effect for image
              const EShimmerEffect(width: 80, height: 80, radius: 20),
              const SizedBox(width: ESizes.spaceBtwItems),

              // Shimmer effect for text
              Padding(
                padding: EdgeInsets.only(top: ESizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    EShimmerEffect(width: 200, height: 15),
                    SizedBox(height: ESizes.spaceBtwItems / 2),
                    EShimmerEffect(width: 150, height: 12),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
