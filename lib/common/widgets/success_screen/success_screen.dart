import 'package:ecom_app/common/styles/spacing_styles.dart';
import 'package:flutter/material.dart';

import '../../../utils/constaints/sizes.dart';
import '../../../utils/constaints/text_string.dart';
import '../../../utils/helpers/helper_funtions.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.onPressed});

  final String image, title, subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: ESpacingStyle.paddingWithAppBarHeight * 2,
          child: Column(
            children: [
              // Image
              Image(
                width: EHelperFuntions.screenWidth() * 0.6,
                image: AssetImage(image),
              ),
              const SizedBox(
                height: ESizes.spaceBtwSeccions,
              ),

              // title and subtitle
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: ESizes.spaceBtwItems,
              ),
              Text(
                subTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: ESizes.spaceBtwSeccions,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onPressed,
                  child: const Text(ETexts.eContinueToSign),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
