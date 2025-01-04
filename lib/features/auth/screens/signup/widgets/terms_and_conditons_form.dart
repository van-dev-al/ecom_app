import 'package:ecom_app/features/auth/controllers/signup/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constaints/colors.dart';
import '../../../../../utils/constaints/sizes.dart';
import '../../../../../utils/constaints/text_string.dart';
import '../../../../../utils/helpers/helper_funtions.dart';

class ETermsAndConditionCheckBox extends StatelessWidget {
  const ETermsAndConditionCheckBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFuntions.isDarkMode(context);
    final controller = SignupController.instance;

    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Obx(
            () => Checkbox(
                value: controller.privacy.value,
                onChanged: (value) =>
                    controller.privacy.value = !controller.privacy.value),
          ),
        ),
        const SizedBox(
          width: ESizes.spaceBtwItems,
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                  text: '${ETexts.iAgreeTo} ',
                  style: Theme.of(context).textTheme.bodySmall),
              TextSpan(
                text: ETexts.privacyPolicy,
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: dark ? EColors.white : EColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: dark ? EColors.white : EColors.primary,
                    ),
              ),
              TextSpan(
                  text: ' ${ETexts.and} ',
                  style: Theme.of(context).textTheme.bodySmall),
              TextSpan(
                text: ETexts.termsOfUse,
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: dark ? EColors.white : EColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: dark ? EColors.white : EColors.primary,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
