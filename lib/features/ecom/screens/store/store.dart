import 'package:ecom_app/common/widgets/appbar/appbar.dart';
import 'package:ecom_app/common/widgets/appbar/tabbar.dart';
import 'package:ecom_app/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:ecom_app/common/widgets/layouts/grid_layout.dart';
import 'package:ecom_app/common/widgets/products/compare/compare_menu_icon.dart';
import 'package:ecom_app/common/widgets/search_fields/search_screen.dart';
import 'package:ecom_app/common/widgets/shimmers/trademark_shimmer.dart';
import 'package:ecom_app/common/widgets/text/search_heading.dart';
import 'package:ecom_app/common/widgets/trademark/trademark_card.dart';
import 'package:ecom_app/features/ecom/controllers/category_controller.dart';
import 'package:ecom_app/features/ecom/controllers/trademark_controller.dart';
import 'package:ecom_app/features/ecom/models/category_model.dart';
import 'package:ecom_app/features/ecom/models/products/product_model.dart';
import 'package:ecom_app/features/ecom/models/trademark_model.dart';
import 'package:ecom_app/features/ecom/screens/all_trademark/all_tradermarks.dart';
import 'package:ecom_app/features/ecom/screens/all_trademark/trademark_products.dart';
import 'package:ecom_app/features/ecom/screens/compare/compare.dart';
import 'package:ecom_app/features/ecom/screens/store/widgets/category_tab.dart';
import 'package:ecom_app/utils/constaints/colors.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:ecom_app/utils/helpers/helper_funtions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen(
      {super.key,
      required this.product,
      required this.trademark,
      required this.category});

  final CategoryModel category;
  final ProductModel product;
  final TrademarkModel trademark;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFuntions.isDarkMode(context);
    final buttonTextColor = dark ? EColors.light : EColors.dark;
    final categories = CategoryController.instance;
    final trademarkController = Get.put(TrademarkController());

    final initialTabIndex = categories.featuresCategories
        .indexWhere((cat) => cat.name == category.name);

    final tabIndex = initialTabIndex >= 0 ? initialTabIndex : 0;

    return DefaultTabController(
      length: categories.featuresCategories.length,
      initialIndex: tabIndex,
      child: Scaffold(
        appBar: EAppBar(
          title: Text('Categories',
              style: Theme.of(context).textTheme.headlineMedium),
          actions: [
            ECompareCounterIcon(
                onPressed: () => Get.to(() => CompareScreen(product: product))),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                floating: true,
                expandedHeight: 410,
                automaticallyImplyLeading: false,
                backgroundColor: dark ? EColors.dark : EColors.white,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(ESizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const SizedBox(height: ESizes.spaceBtwItems),
                      ESearchContainer(
                        text: 'Search in Store',
                        showBorder: true,
                        showBackground: false,
                        padding: EdgeInsets.zero,
                        onTap: () => Get.to(() =>
                            const ESearchScreen(title: 'Search in Store')),
                      ),
                      const SizedBox(height: ESizes.spaceBtwSeccions),
                      // trademark
                      ESectionHeading(
                        title: 'Feartures Trademarks',
                        buttonTextColor: buttonTextColor,
                        onPressed: () =>
                            Get.to(() => AllTradermarks(product: product)),
                      ),
                      const SizedBox(height: ESizes.spaceBtwItems / 1.5),
                      // all tradermarks
                      Obx(() {
                        if (trademarkController.isLoading.value) {
                          return const ETrademarkShimmer();
                        }

                        if (trademarkController.fearturedTrademark.isEmpty) {
                          return Center(
                              child: Text('No data found!',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .apply(color: Colors.white)));
                        }
                        return EGridLayout(
                          itemCount:
                              trademarkController.fearturedTrademark.length,
                          mainAxisExtent: 60,
                          itemBuilder: (context, index) {
                            final trademark =
                                trademarkController.fearturedTrademark[index];
                            return ETrademarkCard(
                              showBorder: true,
                              trademark: trademark,
                              onTap: () => Get.to(() => TrademarkProducts(
                                  trademark: trademark, categoryId: '')),
                            );
                          },
                        );
                      }),
                    ],
                  ),
                ),
                bottom: ETabBar(
                  tabs: categories.featuresCategories
                      .map((category) => Tab(child: Text(category.name)))
                      .toList(),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: categories.featuresCategories
                .map((category) => ECategoryTab(
                      category: category,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
