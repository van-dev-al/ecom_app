import 'package:ecom_app/common/widgets/custom_shapes/containers/rouded_container.dart';
import 'package:ecom_app/features/ecom/models/trademark_model.dart';
import 'package:ecom_app/features/ecom/screens/all_trademark/category_trademark_product.dart';
import 'package:ecom_app/utils/constaints/colors.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'trademark_card.dart';

class ETrademarkShowcase extends StatelessWidget {
  const ETrademarkShowcase({
    super.key,
    required this.trademark,
  });

  final TrademarkModel trademark;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => CategoryTrademarkProduct(
            trademark: trademark,
            categoryId: trademark.categoryId!,
          )),
      child: ERoundedContainer(
        showBorder: true,
        borderColor: EColors.darkGrey,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(ESizes.md / 2),
        margin: const EdgeInsets.only(bottom: ESizes.spaceBtwItems),
        child: Column(
          children: [
            // trademark
            ETrademarkCard(
              showBorder: false,
              trademark: trademark,
            ),
          ],
        ),
      ),
    );
  }
}
