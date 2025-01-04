import 'package:ecom_app/common/widgets/shimmers/shimmer.dart';
import 'package:ecom_app/features/ecom/models/products/product_model.dart';
import 'package:ecom_app/features/ecom/screens/compare/compare.dart';
import 'package:ecom_app/features/pers/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/products/compare/compare_menu_icon.dart';
import '../../../../../utils/constaints/colors.dart';
import '../../../../../utils/constaints/text_string.dart';

class EHomeAppBar extends StatelessWidget {
  const EHomeAppBar({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return EAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ETexts.homeAppBarTitle,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: EColors.grey),
          ),
          Obx(() {
            if (controller.profileLoading.value) {
              return const EShimmerEffect(width: 80, height: 15);
            } else {
              return Text(
                controller.user.value.fullName,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(color: EColors.white),
              );
            }
          }),
        ],
      ),
      actions: [
        ECompareCounterIcon(
          onPressed: () => Get.to(() => CompareScreen(product: product)),
          iconColor: EColors.white,
        ),
      ],
    );
  }
}
