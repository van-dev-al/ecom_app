import 'package:ecom_app/common/widgets/appbar/appbar.dart';
import 'package:ecom_app/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:ecom_app/common/widgets/products/sortable/sortable_compare_product.dart';
import 'package:ecom_app/common/widgets/shimmers/mini_horizontal_product_shimmer.dart';
import 'package:ecom_app/common/widgets/shimmers/shimmer.dart';
import 'package:ecom_app/features/ecom/controllers/products/compare_product_controller.dart';
import 'package:ecom_app/features/ecom/models/products/product_model.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompareProductScreen extends StatelessWidget {
  const CompareProductScreen(
      {super.key,
      required this.title,
      required this.product,
      required this.categoryId});

  final String title;
  final ProductModel product;
  final String categoryId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CompareProductController());
    Map<String, dynamic> query = {
      'sortBy': '',
      'page': '1',
      'pageSize': '10',
      'categoryId': product.categoryId,
    };

    return Scaffold(
      appBar: EAppBar(
          title: Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            children: [
              EProductCardHorizontal(
                product: product,
                showCheckOutButton: true,
                showBorder: true,
              ),
              const SizedBox(height: ESizes.spaceBtwSeccions),
              // EMiniProductCardHorizontal(product: product),

              FutureBuilder(
                  future: controller.getCompareProduct(
                      product.name, query, categoryId),
                  builder: (context, snapshot) {
                    var loader = const Column(
                      children: [
                        EShimmerEffect(width: double.infinity, height: 60),
                        SizedBox(height: ESizes.spaceBtwSeccions),
                        EMiniHorizontalProductShimmer(),
                      ],
                    );
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return loader;
                    }

                    if (!snapshot.hasData ||
                        snapshot.data == null ||
                        snapshot.data!.isEmpty) {
                      return const Center(child: Text('No data found.'));
                    }

                    if (snapshot.hasError) {
                      return const Center(child: Text('Something went wrong'));
                    }
                    final compareProducts = snapshot.data!;
                    return ESortableCompareProduct(product: compareProducts);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
