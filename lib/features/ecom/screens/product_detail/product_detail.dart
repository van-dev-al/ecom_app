import 'package:ecom_app/common/widgets/text/search_heading.dart';
import 'package:ecom_app/features/ecom/controllers/products/compare_controller.dart';
import 'package:ecom_app/features/ecom/models/products/product_model.dart';
import 'package:ecom_app/features/ecom/screens/product_detail/product_detail_spec.dart';
import 'package:ecom_app/features/ecom/screens/product_detail/widgets/bottom_add_to_compare.dart';
import 'package:ecom_app/features/ecom/screens/product_detail/widgets/product_meta_data.dart';
import 'package:ecom_app/utils/constaints/colors.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:ecom_app/utils/helpers/helper_funtions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/product_detail_image_slider.dart';
import 'widgets/rating_and_share.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFuntions.isDarkMode(context);
    final buttonTextColor = dark ? EColors.light : EColors.dark;
    final controller = Get.put(CompareController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // product image -------------------------------------------------------------------------------------------
            EProductImageSlider(product: product),

            // product details ----------------------------------------------------------------------------------------
            Padding(
              padding: const EdgeInsets.only(
                  right: ESizes.defaultSpace,
                  left: ESizes.defaultSpace,
                  bottom: ESizes.defaultSpace),
              child: Column(
                children: [
                  // rating and share buttton
                  ERatingAndShare(product: product),
                  // price, title and brand
                  EProductMetaData(product: product),
                  // check out button
                  const SizedBox(height: ESizes.spaceBtwSeccions),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final uri = Uri.parse(product.urls);
                        launchUrl(uri, mode: LaunchMode.externalApplication);
                      },
                      child: const Text('Check out'),
                    ),
                  ),
                  const SizedBox(height: ESizes.spaceBtwSeccions / 1.5),

                  /// technical specifications
                  ESectionHeading(
                    onPressed: () => Get.to(
                        () => ProductDetailsSpecScreen(product: product)),
                    title: 'Technical Specifications',
                    showActionButton: true,
                    buttonTextColor: buttonTextColor,
                  ),
                  const SizedBox(height: ESizes.spaceBtwItems / 2),
                ],
              ),
            ),
          ],
        ),
      ),

      // add to detail compare button
      floatingActionButton: EBottomAddToCompare(
        onPressed: () {
          controller.addProductToCompare(product);
        },
        label: 'Compare specifications',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
