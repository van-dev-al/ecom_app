import 'package:flutter/material.dart';

import '../../../../utils/constaints/colors.dart';
import '../curved_edges/curved_edges_widget.dart';
import 'circular_container.dart';

class EPrimaryHeaderContainer extends StatelessWidget {
  const EPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ECurvedEdgeWidget(
      /// Header Container home widget custom
      child: Container(
        color: EColors.primary,
        child: Stack(
          children: [
            Positioned(
              top: -150,
              right: -150,
              child: ECircularContainer(
                backgroundColor: EColors.textWhite.withOpacity(0.1),
              ),
            ),
            Positioned(
              top: 100,
              right: -250,
              child: ECircularContainer(
                backgroundColor: EColors.textWhite.withOpacity(0.1),
              ),
            ),
            Positioned(
              top: 150,
              right: 200,
              child: ECircularContainer(
                backgroundColor: EColors.textWhite.withOpacity(0.1),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
