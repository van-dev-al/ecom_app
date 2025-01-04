import 'package:ecom_app/common/widgets/appbar/appbar.dart';
import 'package:ecom_app/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:ecom_app/common/widgets/products/sortable/sortable_search_product.dart';
import 'package:ecom_app/common/widgets/shimmers/veltical_product_shimmer.dart';
import 'package:ecom_app/features/ecom/models/products/product_model.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:ecom_app/features/ecom/controllers/all_products/all_search_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllSearchProduct extends StatelessWidget {
  const AllSearchProduct(
      {super.key,
      required this.title,
      this.query,
      this.futureMethod,
      required this.keyWord});

  final String keyWord;
  final String title;
  final Map<String, dynamic>? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllSearchController());
    return Scaffold(
      appBar: EAppBar(
        title: Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(ESizes.defaultSpace),
            child: Column(
              children: [
                ESearchContainer(
                    text: keyWord,
                    padding: const EdgeInsets.only(
                        top: ESizes.zero,
                        left: ESizes.zero,
                        right: ESizes.zero,
                        bottom: ESizes.spaceBtwItems),
                    style: Theme.of(context).textTheme.headlineSmall),
                FutureBuilder<List<ProductModel>>(
                  future: futureMethod ??
                      controller.fetchProductsBySearchQuery(keyWord),
                  builder: (context, snapshot) {
                    const loader = EVelticalProductShimmer();

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return loader;
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    if (!snapshot.hasData ||
                        snapshot.data == null ||
                        snapshot.data!.isEmpty) {
                      return Center(
                          child: Text('No product info with: $keyWord found.'));
                    }

                    final products = snapshot.data!;
                    return ESortableSearchProduct(product: products);
                  },
                ),
              ],
            )),
      ),
    );
  }
}
