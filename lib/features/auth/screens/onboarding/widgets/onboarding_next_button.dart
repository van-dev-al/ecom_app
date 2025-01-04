import 'package:ecom_app/features/auth/controllers/onboarding/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constaints/colors.dart';
import '../../../../../utils/constaints/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../../utils/helpers/helper_funtions.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFuntions.isDarkMode(context);

    return Positioned(
      bottom: EDeviceUtils.getBottomNavigationBarHeight(),
      right: ESizes.defaultSpace,
      child: ElevatedButton(
        onPressed: () => OnBoardingController.instance.nextPage(),
        style: ElevatedButton.styleFrom(
            side: BorderSide.none,
            shape: const CircleBorder(),
            backgroundColor: dark ? EColors.primary : Colors.black),
        child: const Icon(Iconsax.arrow_right_3),
      ),
    );
  }
}
