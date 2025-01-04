import 'package:ecom_app/common/widgets/appbar/appbar.dart';
import 'package:ecom_app/common/widgets/products/sortable/sortable_category_trademark_product.dart';
import 'package:ecom_app/common/widgets/shimmers/shimmer.dart';
import 'package:ecom_app/common/widgets/shimmers/veltical_product_shimmer.dart';
import 'package:ecom_app/common/widgets/trademark/trademark_card.dart';
import 'package:ecom_app/features/ecom/controllers/category_trademark_controller.dart';
import 'package:ecom_app/features/ecom/models/trademark_model.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:ecom_app/utils/formatters/formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryTrademarkProduct extends StatelessWidget {
  const CategoryTrademarkProduct(
      {super.key, required this.trademark, required this.categoryId});

  final TrademarkModel trademark;
  final String categoryId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryTrademarkController());
    final titleCapitalizeF = EFormatter.capitalizeFirst(trademark.source);

    Map<String, dynamic> query = {
      'sortBy': '',
      'page': '1',
      'pageSize': '10',
      'categories': categoryId,
    };
    //
    return Scaffold(
      appBar: EAppBar(
        title: Text(titleCapitalizeF,
            style: Theme.of(context).textTheme.headlineMedium),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            children: [
              // trademarks detail
              ETrademarkCard(
                showBorder: true,
                trademark: trademark,
              ),
              const SizedBox(height: ESizes.spaceBtwSeccions),

              FutureBuilder(
                future: controller.getTrademarkProducts(
                    trademark.source, query, categoryId),
                builder: (context, snapshot) {
                  var loader = const Column(
                    children: [
                      EShimmerEffect(width: double.infinity, height: 60),
                      SizedBox(height: ESizes.spaceBtwSeccions),
                      EVelticalProductShimmer(),
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
                  final trademarkProducts = snapshot.data!;
                  return ESortableCategoryTrademarkProduct(
                      product: trademarkProducts);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
