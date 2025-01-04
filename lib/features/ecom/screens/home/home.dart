import 'package:ecom_app/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:ecom_app/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:ecom_app/common/widgets/layouts/grid_layout.dart';
import 'package:ecom_app/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:ecom_app/common/widgets/search_fields/search_screen.dart';
import 'package:ecom_app/common/widgets/shimmers/veltical_product_shimmer.dart';
import 'package:ecom_app/common/widgets/text/search_heading.dart';
import 'package:ecom_app/features/ecom/controllers/products/product_controller.dart';
import 'package:ecom_app/features/ecom/models/products/product_model.dart';
import 'package:ecom_app/features/ecom/models/trademark_model.dart';
import 'package:ecom_app/features/ecom/screens/all_products/all_popular_product.dart';
import 'package:ecom_app/utils/constaints/colors.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:ecom_app/utils/helpers/helper_funtions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/home_appbar.dart';
import 'widgets/home_categories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.product});

  final ProductModel product;

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    final dark = EHelperFuntions.isDarkMode(context);
    final buttonTextColor = dark ? EColors.light : EColors.dark;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// header
            EPrimaryHeaderContainer(
              child: Column(
                children: [
                  // app bar
                  EHomeAppBar(product: widget.product),
                  const SizedBox(height: ESizes.spaceBtwSeccions),

                  // seach bar
                  ESearchContainer(
                      text: 'Search your Favorites',
                      onTap: () => Get.to(() =>
                          const ESearchScreen(title: 'Search your Favorites'))),
                  const SizedBox(height: ESizes.spaceBtwSeccions),

                  // category
                  Padding(
                    padding: const EdgeInsets.only(left: ESizes.defaultSpace),
                    child: Column(
                      children: [
                        // heading
                        const ESectionHeading(
                          title: 'Popular categories',
                          showActionButton: false,
                          textColor: EColors.white,
                        ),
                        const SizedBox(height: ESizes.spaceBtwItems),

                        // category
                        EHomeCategories(
                            product: widget.product,
                            trademark: TrademarkModel.empty()),
                      ],
                    ),
                  ),
                  const SizedBox(height: ESizes.spaceBtwSeccions)
                ],
              ),
            ),

            // body
            Padding(
              padding: const EdgeInsets.only(
                  top: ESizes.defaultSpace / 2.5,
                  left: ESizes.defaultSpace,
                  bottom: ESizes.defaultSpace,
                  right: ESizes.defaultSpace),
              child: Column(
                children: [
                  // banner
                  // EBannerSlider(
                  //   banners: [
                  //     EImages.bannerImage1,
                  //     EImages.bannerImage2,
                  //     EImages.bannerImage3
                  //   ],
                  // ),
                  // popular products
                  ESectionHeading(
                    onPressed: () {
                      Map<String, dynamic> query = {
                        'categories': '',
                        'sortBy': '',
                        'page': '1',
                        'pageSize': '10',
                      };
                      Get.to(() => AllPopularProduct(
                            title: 'Popular Products',
                            query: query,
                          ));
                    },
                    title: 'Popular Products',
                    showActionButton: true,
                    buttonTextColor: buttonTextColor,
                  ),
                  const SizedBox(height: ESizes.spaceBtwItems),

                  //
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const EVelticalProductShimmer();
                    }

                    if (controller.featuredProducts.isEmpty) {
                      return Center(
                          child: Text('No data found!',
                              style: Theme.of(context).textTheme.bodyMedium));
                    }

                    return EGridLayout(
                      itemCount: 4,
                      itemBuilder: (_, index) => EProductCardVertical(
                          product: controller.featuredProducts[index]),
                    );
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
