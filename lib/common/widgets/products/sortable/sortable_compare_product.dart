import 'package:ecom_app/common/widgets/products/product_cards/mini_product_card_horizontal.dart';
import 'package:ecom_app/common/widgets/shimmers/mini_horizontal_product_shimmer.dart';
import 'package:ecom_app/features/ecom/controllers/products/compare_product_controller.dart';
import 'package:ecom_app/features/ecom/models/products/product_model.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class ESortableCompareProduct extends StatelessWidget {
  const ESortableCompareProduct({super.key, required this.product});

  final List<ProductModel> product;

  @override
  Widget build(BuildContext context) {
    final controller = CompareProductController.instance;

    controller.assignProducts(product);

    final name = product[0].name;
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
            controller.sortProducts(name, value!, categoryId);
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
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      // controller: scrollController, // Gắn controller nếu cần
                      itemCount: controller.products.length,
                      itemBuilder: (_, index) => EMiniProductCardHorizontal(
                        product: controller.products[index],
                      ),
                    ),
                    if (controller.isLoading.value)
                      const Column(
                        children: [
                          SizedBox(height: ESizes.spaceBtwItems),
                          EMiniHorizontalProductShimmer(itemCount: 4)
                        ],
                      ),
                    if (!controller.isLoading.value && controller.hasMoreData)
                      Padding(
                        padding:
                            const EdgeInsets.only(top: ESizes.spaceBtwItems),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () =>
                                controller.loadMoreProducts(name, categoryId),
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
