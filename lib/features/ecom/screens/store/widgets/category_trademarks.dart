import 'package:ecom_app/common/widgets/shimmers/list_shimmer.dart';
import 'package:ecom_app/common/widgets/trademark/trademark_show_case.dart';
import 'package:ecom_app/features/ecom/controllers/trademark_controller.dart';
import 'package:ecom_app/features/ecom/models/category_model.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:flutter/material.dart';

class CategoryTrademarks extends StatelessWidget {
  const CategoryTrademarks({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = TrademarkController.instance;

    return FutureBuilder(
        future: controller.getTrademarksForCategory(category.categoryId),
        builder: (context, snapshot) {
          const loader = Column(
            children: [
              EListShimmer(),
              SizedBox(height: ESizes.spaceBtwItems),
              EListShimmer(),
            ],
          );
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loader;
          }

          if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.isEmpty) {
            return const Center(child: Text('No data trademark found.'));
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }
          final trademarks = snapshot.data;
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: trademarks!.length,
            itemBuilder: (_, index) {
              final trademark = trademarks[index];
              return ETrademarkShowcase(trademark: trademark);
            },
          );
        });
  }
}
