import 'package:ecom_app/features/auth/controllers/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constaints/colors.dart';
import '../../../utils/constaints/image_string.dart';
import '../../../utils/constaints/sizes.dart';

class ESocialButtons extends StatelessWidget {
  const ESocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: EColors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
              onPressed: () => controller.googleSignIn(),
              icon: const Image(
                width: ESizes.md,
                height: ESizes.md,
                image: AssetImage(EImages.google),
              )),
        ),
        const SizedBox(
          width: ESizes.spaceBtwItems,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: EColors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
              onPressed: () {},
              icon: const Image(
                width: ESizes.md,
                height: ESizes.md,
                image: AssetImage(EImages.facebook),
              )),
        ),
      ],
    );
  }
}
