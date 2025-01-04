import 'package:ecom_app/common/widgets/appbar/appbar.dart';
import 'package:ecom_app/common/widgets/layouts/grid_layout.dart';
import 'package:ecom_app/common/widgets/shimmers/trademark_shimmer.dart';
import 'package:ecom_app/common/widgets/text/search_heading.dart';
import 'package:ecom_app/common/widgets/trademark/trademark_card.dart';
import 'package:ecom_app/features/ecom/controllers/trademark_controller.dart';
import 'package:ecom_app/features/ecom/models/products/product_model.dart';
import 'package:ecom_app/features/ecom/screens/all_trademark/trademark_products.dart';
import 'package:ecom_app/utils/constaints/colors.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:ecom_app/utils/helpers/helper_funtions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllTradermarks extends StatelessWidget {
  const AllTradermarks({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFuntions.isDarkMode(context);
    final buttonTextColor = dark ? EColors.light : EColors.dark;
    final controller = TrademarkController.instance;
    return Scaffold(
      appBar: EAppBar(
        title: Text(
          'All Trademarks',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            children: [
              //heading
              ESectionHeading(
                  title: 'Trademarks',
                  showActionButton: false,
                  buttonTextColor: buttonTextColor),
              const SizedBox(height: ESizes.spaceBtwSeccions),

              // trademark
              Obx(() {
                if (controller.isLoading.value) {
                  return const ETrademarkShimmer();
                }

                if (controller.fearturedTrademark.isEmpty) {
                  return Center(
                      child: Text('No data found!',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .apply(color: Colors.white)));
                }
                return EGridLayout(
                    itemCount: controller.fearturedTrademark.length,
                    mainAxisExtent: 60,
                    itemBuilder: (context, index) {
                      final trademark = controller.fearturedTrademark[index];
                      return ETrademarkCard(
                        showBorder: true,
                        trademark: trademark,
                        onTap: () => Get.to(() => TrademarkProducts(
                              trademark: trademark,
                            )),
                      );
                    });
              }),
            ],
          ),
        ),
      ),
    );
  }
}
