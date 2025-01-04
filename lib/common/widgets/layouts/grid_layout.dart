import 'package:flutter/material.dart';

import '../../../utils/constaints/sizes.dart';

class EGridLayout extends StatelessWidget {
  const EGridLayout({
    super.key,
    required this.itemCount,
    this.mainAxisExtent = 288,
    required this.itemBuilder,
    this.controller,
  });

  final ScrollController? controller;
  final int itemCount;
  final double? mainAxisExtent;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: controller,
      itemCount: itemCount,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: mainAxisExtent,
        mainAxisSpacing: ESizes.gridViewSpacing,
        crossAxisSpacing: ESizes.gridViewSpacing,
      ),
      itemBuilder: itemBuilder,
    );
  }
}
