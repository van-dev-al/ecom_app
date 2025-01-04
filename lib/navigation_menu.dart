import 'package:ecom_app/features/ecom/controllers/all_products/all_category_product_controller.dart';
import 'package:ecom_app/features/ecom/controllers/products/compare_controller.dart';
import 'package:ecom_app/features/ecom/controllers/products/favorite_controller.dart';
import 'package:ecom_app/features/ecom/controllers/products/product_controller.dart';
import 'package:ecom_app/features/ecom/controllers/search_history_controller.dart';
import 'package:ecom_app/features/ecom/models/category_model.dart';
import 'package:ecom_app/features/ecom/models/products/product_model.dart';
import 'package:ecom_app/features/ecom/models/trademark_model.dart';
import 'package:ecom_app/features/ecom/screens/favorite/favorite.dart';
import 'package:ecom_app/features/ecom/screens/home/home.dart';
import 'package:ecom_app/features/ecom/screens/new/new.dart';
import 'package:ecom_app/features/ecom/screens/store/store.dart';
import 'package:ecom_app/features/pers/screens/settings/settings.dart';
import 'package:ecom_app/utils/constaints/colors.dart';
import 'package:ecom_app/utils/helpers/helper_funtions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = EHelperFuntions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          backgroundColor: darkMode ? EColors.black : EColors.white,
          indicatorColor: darkMode
              ? EColors.white.withOpacity(0.1)
              : EColors.black.withOpacity(0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(
                icon: Icon(Iconsax.shop), label: 'Categories'),
            NavigationDestination(icon: Icon(Iconsax.book), label: 'News'),
            NavigationDestination(
                icon: Icon(Iconsax.heart), label: 'Favorites'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final ProductModel product = ProductModel.empty();

  late final List<Widget> screens;

  @override
  void onInit() {
    super.onInit();
    Get.put(FavoriteController());
    Get.put(ProductController());
    Get.put(CompareController());
    Get.put(SearchHistoryController());
    Get.put(AllCategoryProductController());
    screens = [
      HomeScreen(product: product),
      StoreScreen(
          product: product,
          trademark: TrademarkModel.empty(),
          category: CategoryModel.empty()),
      const NewScreen(),
      FavoriteScreen(product: product),
      const SettingsScreen(),
    ];
  }
}
