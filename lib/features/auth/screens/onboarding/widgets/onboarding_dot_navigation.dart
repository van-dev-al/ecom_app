import 'package:ecom_app/features/auth/controllers/onboarding/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../utils/constaints/colors.dart';
import '../../../../../utils/constaints/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../../utils/helpers/helper_funtions.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    final dark = EHelperFuntions.isDarkMode(context);

    return Positioned(
        bottom: EDeviceUtils.getBottomNavigationBarHeight() + 25,
        left: ESizes.defaultSpace,
        child: SmoothPageIndicator(
          controller: controller.pageController,
          onDotClicked: controller.dotNavigationClick,
          count: 3,
          effect: ExpandingDotsEffect(
              activeDotColor: dark ? EColors.light : EColors.dark,
              dotHeight: 10),
        ));
  }
}
