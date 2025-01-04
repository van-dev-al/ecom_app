import 'package:ecom_app/features/auth/controllers/onboarding/onboarding_controller.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constaints/sizes.dart';
import '../../../../../utils/device/device_utility.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: EDeviceUtils.getAppBarHeight(),
        right: ESizes.defaultSpace,
        child: TextButton(
          onPressed: () => OnBoardingController.instance.skipPage(),
          child: const Text('Skip'),
        ));
  }
}
