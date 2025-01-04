import 'package:ecom_app/common/widgets/layouts/grid_layout.dart';
import 'package:ecom_app/common/widgets/shimmers/shimmer.dart';
import 'package:flutter/material.dart';

class ETrademarkShimmer extends StatelessWidget {
  const ETrademarkShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return EGridLayout(
      mainAxisExtent: 80,
      itemCount: itemCount,
      itemBuilder: (_, __) => const EShimmerEffect(width: 300, height: 80),
    );
  }
}
