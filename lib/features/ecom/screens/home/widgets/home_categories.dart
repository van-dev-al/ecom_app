import 'package:ecom_app/common/widgets/image_text/horizontal_image_text.dart';
import 'package:ecom_app/common/widgets/shimmers/category_shimmer.dart';
import 'package:ecom_app/features/ecom/controllers/category_controller.dart';
import 'package:ecom_app/features/ecom/models/products/product_model.dart';
import 'package:ecom_app/features/ecom/models/trademark_model.dart';
import 'package:ecom_app/features/ecom/screens/store/store.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EHomeCategories extends StatelessWidget {
  const EHomeCategories({
    super.key,
    required this.product,
    required this.trademark,
  });

  final ProductModel product;
  final TrademarkModel trademark;

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());

    return Obx(() {
      if (categoryController.isLoading.value) return const ECategoryShimmer();

      if (categoryController.featuresCategories.isEmpty) {
        return Center(
          child: Text('No data found!',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .apply(color: Colors.white)),
        );
      }

      return SizedBox(
        height: 40,
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: categoryController.featuresCategories.length,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (_, __) =>
              const SizedBox(width: ESizes.defaultSpace / 2),
          itemBuilder: (_, index) {
            final category = categoryController.featuresCategories[index];
            return EHorizontalImageText(
              image: category.image,
              title: category.name,
              onTap: () => Get.to(() => StoreScreen(
                  product: product, trademark: trademark, category: category)),
            );
          },
        ),
      );
    });
  }
}
