import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecom_app/utils/constaints/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../../../common/widgets/images/rounded_image.dart';
import '../../../../../utils/constaints/sizes.dart';
import '../../../controllers/home_controller.dart';

class EBannerSlider extends StatelessWidget {
  const EBannerSlider({
    super.key,
    required this.banners,
  });

  final List<String> banners;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1,
            onPageChanged: (index, _) => controller.updatePageIndicator(index),
          ),
          items: banners.map((url) => ERoundedImage(imageUrl: url)).toList(),
        ),
        const SizedBox(height: ESizes.spaceBtwItems),
        Obx(
          () => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < banners.length; i++)
                ECircularContainer(
                  width: 20,
                  height: 5,
                  margin: const EdgeInsets.only(right: 10),
                  backgroundColor: controller.carouselCurrentIndex.value == i
                      ? EColors.primary
                      : EColors.grey,
                )
            ],
          ),
        )
      ],
    );
  }
}
