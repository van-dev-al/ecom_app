import 'package:ecom_app/common/widgets/layouts/grid_layout.dart';
import 'package:ecom_app/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:ecom_app/common/widgets/text/search_heading.dart';
import 'package:ecom_app/features/ecom/controllers/all_products/all_category_product_controller.dart';
import 'package:ecom_app/features/ecom/models/category_model.dart';
import 'package:ecom_app/features/ecom/screens/all_products/all_category_product.dart';
import 'package:ecom_app/features/ecom/screens/store/widgets/category_trademarks.dart';
import 'package:ecom_app/utils/constaints/colors.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:ecom_app/utils/helpers/helper_funtions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ECategoryTab extends StatelessWidget {
  const ECategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFuntions.isDarkMode(context);
    final buttonTextColor = dark ? EColors.light : EColors.dark;
    final controller = AllCategoryProductController.instance;

    Map<String, dynamic> query = {
      'sortBy': '',
      'page': '1',
      'pageSize': '10',
      'categories': category.categoryId,
    };

    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(ESizes.defaultSpace),
            child: Column(
              children: [
                // tradermark
                CategoryTrademarks(category: category),
                const SizedBox(height: ESizes.spaceBtwItems),

                // product
                FutureBuilder(
                    future: controller.getTrademarkCategoryProducts(
                        categoryId: category.categoryId, query: query),
                    builder: (context, snapshot) {
                      //
                      if (!snapshot.hasData ||
                          snapshot.data == null ||
                          snapshot.data!.isEmpty) {
                        return const Center(child: Text('No product found.'));
                      }

                      if (snapshot.hasError) {
                        return const Center(
                            child: Text('Something went wrong'));
                      }
                      final product = snapshot.data!;
                      return Column(
                        children: [
                          ESectionHeading(
                            title: 'You might like!',
                            buttonTextColor: buttonTextColor,
                            onPressed: () => Get.to(AllCategoryProduct(
                              title: category.name,
                              futureMethod:
                                  controller.getTrademarkCategoryProducts(
                                      categoryId: category.categoryId,
                                      limit: -1,
                                      query: query),
                              categoryId: category.categoryId,
                            )),
                          ),
                          const SizedBox(height: ESizes.spaceBtwItems),
                          EGridLayout(
                              itemCount: product.length,
                              itemBuilder: (_, index) =>
                                  EProductCardVertical(product: product[index]))
                        ],
                      );
                    }),
              ],
            ),
          ),
        ]);
  }
}
