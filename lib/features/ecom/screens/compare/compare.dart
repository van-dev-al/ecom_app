import 'package:ecom_app/common/widgets/appbar/appbar.dart';
import 'package:ecom_app/features/ecom/controllers/products/compare_controller.dart';
import 'package:ecom_app/features/ecom/models/products/product_model.dart';
import 'package:ecom_app/features/ecom/screens/compare_detail/compare_detail.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../product_detail/widgets/bottom_add_to_compare.dart';
import '../../../../common/widgets/products/compare/compare_item.dart';

class CompareScreen extends StatelessWidget {
  const CompareScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = CompareController.instance;
    final compareItems = controller.compareItems;
    return Scaffold(
      appBar: EAppBar(
        showBackArrow: true,
        title: Text(
          'Compare product',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: GestureDetector(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: Obx(() {
            return ListView.separated(
              shrinkWrap: true,
              itemCount: compareItems.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: ESizes.spaceBtwSeccions),
              itemBuilder: (_, index) => Column(
                children: [
                  ECompareItem(product: compareItems[index]),
                  const SizedBox(height: ESizes.spaceBtwItems)
                ],
              ),
            );
          }),
        ),
      ),
      floatingActionButton: EBottomAddToCompare(
        onPressed: () {
          final compareItemsCount = controller.compareItems.length;

          if (compareItemsCount == 0) {
            Get.snackbar(
              'No products selected',
              'Go back select products to compare',
            );
          } else if (compareItemsCount == 1) {
            Get.snackbar('Need one more product to compare',
                'Go back select products to compare');
          } else {
            Get.to(() => CompareDetailScreen(
                  product1: controller.compareItems[0],
                  product2: controller.compareItems[1],
                ));
          }
        },
        label: 'Compare',
        padding: 30,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
