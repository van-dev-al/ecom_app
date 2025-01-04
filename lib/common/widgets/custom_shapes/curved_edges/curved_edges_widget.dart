import 'package:flutter/material.dart';

import 'curved_egdes.dart';

class ECurvedEdgeWidget extends StatelessWidget {
  const ECurvedEdgeWidget({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ECustomCurvedEdges(),
      child: child,
    );
  }
}
