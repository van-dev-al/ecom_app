import 'package:ecom_app/features/auth/controllers/onboarding/onboarding_controller.dart';
import 'package:ecom_app/utils/constaints/image_string.dart';
import 'package:ecom_app/utils/constaints/text_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/onboarding_dot_navigation.dart';
import 'widgets/onboarding_next_button.dart';
import 'widgets/onboarding_page.dart';
import 'widgets/onboarding_skip.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          // horizontal scroll pages
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: EImages.onboardingimage1,
                title: ETexts.onBoardingTitle1,
                subTitle: ETexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: EImages.onboardingimage2,
                title: ETexts.onBoardingTitle2,
                subTitle: ETexts.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                image: EImages.onboardingimage3,
                title: ETexts.onBoardingTitle3,
                subTitle: ETexts.onBoardingSubTitle3,
              ),
            ],
          ),

          // skip buttons
          const OnBoardingSkip(),

          // dot navigation smoothindicators
          const OnBoardingDotNavigation(),

          // circular buttons
          const OnBoardingNextButton()
        ],
      ),
    );
  }
}
