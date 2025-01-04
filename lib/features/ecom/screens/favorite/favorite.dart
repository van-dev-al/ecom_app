import 'package:ecom_app/common/widgets/appbar/appbar.dart';
import 'package:ecom_app/common/widgets/layouts/grid_layout.dart';
import 'package:ecom_app/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:ecom_app/common/widgets/shimmers/veltical_product_shimmer.dart';
import 'package:ecom_app/features/ecom/controllers/products/favorite_controller.dart';
import 'package:ecom_app/features/ecom/models/products/product_model.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = FavoriteController.instance;
    return Scaffold(
      appBar: EAppBar(
        title: Text('Favorites',
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            children: [
              Obx(
                () => FutureBuilder(
                    future: controller.favoriteProducts(),
                    builder: (context, snapshot) {
                      const loader = EVelticalProductShimmer(itemCount: 6);
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return loader;
                      }
                      if (!snapshot.hasData ||
                          snapshot.data == null ||
                          snapshot.data!.isEmpty) {
                        return const Center(child: Text('No data Favorites.'));
                      }

                      if (snapshot.hasError) {
                        return const Center(
                            child: Text('Something went wrong'));
                      }
                      final products = snapshot.data!;
                      return EGridLayout(
                          itemCount: products.length,
                          itemBuilder: (_, index) =>
                              EProductCardVertical(product: products[index]));
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
