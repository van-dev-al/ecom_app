import 'package:ecom_app/utils/helpers/helper_funtions.dart';
import 'package:flutter/material.dart';

import '../../../utils/constaints/colors.dart';

class EDividerForm extends StatelessWidget {
  const EDividerForm({
    super.key,
    required this.diviverText,
  });

  final String diviverText;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFuntions.isDarkMode(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Divider(
            color: dark ? EColors.darkGrey : EColors.grey,
            thickness: 0.5,
            indent: 60,
            endIndent: 5,
          ),
        ),
        Text(
          diviverText,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Flexible(
          child: Divider(
            color: dark ? EColors.darkGrey : EColors.grey,
            thickness: 0.5,
            indent: 5,
            endIndent: 60,
          ),
        ),
      ],
    );
  }
}
