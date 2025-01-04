import 'package:ecom_app/common/widgets/appbar/appbar.dart';
import 'package:ecom_app/common/widgets/products/sortable/sortable_product.dart';
import 'package:ecom_app/common/widgets/shimmers/veltical_product_shimmer.dart';
import 'package:ecom_app/features/ecom/controllers/all_products/all_product_controller.dart';
import 'package:ecom_app/features/ecom/models/products/product_model.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllProducts extends StatelessWidget {
  const AllProducts(
      {super.key, required this.title, this.query, this.futureMethod});

  final String title;
  final Map<String, dynamic>? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductController());
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
          child: FutureBuilder(
            future: futureMethod ?? controller.fetchProductsByQuery(query),
            //
            builder: (context, snapshot) {
              const loader = EVelticalProductShimmer();
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

              final products = snapshot.data!;

              return ESortableProduct(product: products);
            },
          ),
        ),
      ),
    );
  }
}
