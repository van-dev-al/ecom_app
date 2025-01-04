import 'package:flutter/material.dart';

import '../../../../../utils/constaints/sizes.dart';

class EItemNewQcAndShareButton extends StatelessWidget {
  const EItemNewQcAndShareButton({
    super.key,
    this.qc = 'News',
    required this.onPressed,
  });

  final String qc;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [Text(qc, style: Theme.of(context).textTheme.bodySmall)],
        ),
        IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.share, size: ESizes.iconXs),
        )
      ],
    );
  }
}
