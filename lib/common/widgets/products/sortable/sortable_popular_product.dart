import 'package:ecom_app/common/widgets/layouts/grid_layout.dart';
import 'package:ecom_app/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:ecom_app/features/ecom/controllers/all_products/all_popular_product_controller.dart';
import 'package:ecom_app/features/ecom/models/products/product_model.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ESortablePopularProduct extends StatelessWidget {
  const ESortablePopularProduct({
    super.key,
    required this.product,
  });
  final List<ProductModel> product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllPopularProductController());
    // controller.assignProducts(product);

    return Column(
      children: [
        // dropdown
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.sort),
          ),
          value: controller.selectedSortOption.value.isEmpty
              ? null
              : controller.selectedSortOption.value,
          onChanged: (value) {
            controller.sortProducts(value!);
          },
          items: [
            const DropdownMenuItem<String>(
              value: '',
              child: Text('Sort by'),
            ),
            ...['Name', 'Lower Price', 'Higher Price', 'Discount', 'Reviews']
                .map((option) => DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    ))
          ],
        ),
        const SizedBox(height: ESizes.spaceBtwSeccions),

        Obx(
          () => EGridLayout(
              itemCount: controller.products.length,
              itemBuilder: (_, index) =>
                  EProductCardVertical(product: controller.products[index])),
        ),
      ],
    );
  }
}
