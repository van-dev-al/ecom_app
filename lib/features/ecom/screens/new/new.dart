import 'package:ecom_app/common/widgets/new/new_item.dart';
import 'package:ecom_app/common/widgets/appbar/appbar.dart';
import 'package:ecom_app/common/widgets/shimmers/news_shimmer.dart';
import 'package:ecom_app/features/ecom/controllers/news_controller.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewScreen extends StatelessWidget {
  const NewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NewsController());
    return Scaffold(
      appBar: EAppBar(
        showBackArrow: false,
        title: Text(
          'News',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: Obx(() {
            if (controller.isLoading.value) {
              return const ENewsShimmer();
            }

            if (controller.featuredNews.isEmpty) {
              return Center(
                  child: Text('No data found!',
                      style: Theme.of(context).textTheme.bodyMedium));
            }
            return ListView.separated(
              shrinkWrap: true,
              itemCount: controller.featuredNews.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: ESizes.spaceBtwSeccions),
              itemBuilder: (_, index) => Column(
                children: [
                  ENewItem(news: controller.featuredNews[index]),
                ],
              ),
            );
          })),
    );
  }
}
