import 'package:ecom_app/common/widgets/shimmers/shimmer.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:flutter/material.dart';

class ECategoryShimmer extends StatelessWidget {
  const ECategoryShimmer({
    super.key,
    this.itemCount = 6,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: itemCount,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) =>
            const SizedBox(width: ESizes.defaultSpace / 2),
        itemBuilder: (_, index) {
          return const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EShimmerEffect(width: 100, height: 40, radius: 100),
            ],
          );
        },
      ),
    );
  }
}
