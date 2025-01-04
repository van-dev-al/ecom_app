import 'package:ecom_app/common/widgets/layouts/grid_layout.dart';
import 'package:ecom_app/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:ecom_app/common/widgets/shimmers/veltical_product_shimmer.dart';
import 'package:ecom_app/features/ecom/controllers/all_products/all_category_product_controller.dart';
import 'package:ecom_app/features/ecom/models/products/product_model.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ESortableCategoryProduct extends StatelessWidget {
  const ESortableCategoryProduct({
    super.key,
    required this.product,
  });
  final List<ProductModel> product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllCategoryProductController());
    controller.assignProducts(product);

    final scrollController = ScrollController();

    final categoryId = product[0].categoryId;

    return Column(
      children: [
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.sort),
          ),
          value: controller.selectedSortOption.value.isEmpty
              ? null
              : controller.selectedSortOption.value,
          onChanged: (value) {
            controller.sortProducts(categoryId, value!);
          },
          items: [
            const DropdownMenuItem<String>(value: '', child: Text('Sort by')),
            ...['Name', 'Lower Price', 'Higher Price', 'Discount', 'Reviews']
                .map((option) => DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    )),
          ],
        ),
        const SizedBox(height: ESizes.spaceBtwSeccions),
        Obx(
          () => controller.products.isEmpty
              ? const Center(child: Text('No data found.'))
              : Column(
                  children: [
                    EGridLayout(
                      controller: scrollController,
                      itemCount: controller.products.length,
                      itemBuilder: (_, index) => EProductCardVertical(
                        product: controller.products[index],
                      ),
                    ),
                    if (controller.isLoadingMore.value)
                      const Column(
                        children: [
                          SizedBox(height: ESizes.spaceBtwItems),
                          EVelticalProductShimmer(),
                        ],
                      ),
                    if (!controller.isLoadingMore.value &&
                        controller.hasMoreData)
                      Padding(
                        padding:
                            const EdgeInsets.only(top: ESizes.spaceBtwItems),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () =>
                                controller.loadMoreProducts(categoryId),
                            child: const Text('Load more'),
                          ),
                        ),
                      ),
                  ],
                ),
        ),
      ],
    );
  }
}
