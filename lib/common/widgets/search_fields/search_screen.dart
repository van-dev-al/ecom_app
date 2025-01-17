import 'package:ecom_app/common/widgets/appbar/appbar.dart';
import 'package:ecom_app/features/ecom/controllers/search_history_controller.dart';
import 'package:ecom_app/features/ecom/screens/all_products/all_search_product.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ESearchScreen extends StatefulWidget {
  const ESearchScreen({super.key, required this.title});

  final String title;

  @override
  State<ESearchScreen> createState() => ESearchScreenState();
}

class ESearchScreenState extends State<ESearchScreen> {
  final TextEditingController searchFieldController = TextEditingController();
  final searchHistoryController = SearchHistoryController.instance;

  @override
  void initState() {
    super.initState();
    searchHistoryController.fetchSearchHistory();
  }

  void onSearch(String keyword) {
    if (keyword.isNotEmpty) {
      Get.snackbar("Searching", "You are searching for: $keyword");
      Get.to(() => AllSearchProduct(title: widget.title, keyWord: keyword))
          ?.then((_) {
        searchHistoryController.fetchSearchHistory();
      });
    } else {
      Get.snackbar(
          "No Input", "Please enter the keyword you want to search for.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EAppBar(
        title: Text(widget.title,
            style: Theme.of(context).textTheme.headlineMedium),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(ESizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: searchFieldController,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Search ...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              style: Theme.of(context).textTheme.bodyLarge,
              onSubmitted: (keyword) {
                onSearch(keyword);
              },
            ),
            const SizedBox(height: ESizes.spaceBtwItems),
            Obx(() {
              if (searchHistoryController.isLoading.value) {
                return const Center(
                    child: Column(
                  children: [
                    SizedBox(height: ESizes.spaceBtwItems),
                    CircularProgressIndicator(),
                  ],
                ));
              }

              if (searchHistoryController.searchHistory.isEmpty) {
                return Center(
                  child: Text(
                    'No search history available.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                );
              }

              return Expanded(
                child: ListView.separated(
                  itemCount: searchHistoryController.searchHistory.length,
                  separatorBuilder: (context, index) => const Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  itemBuilder: (context, index) {
                    final historyItem =
                        searchHistoryController.searchHistory[index];

                    return ListTile(
                      leading: const Icon(Icons.history),
                      title: Text(
                        historyItem.query,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      onTap: () {
                        onSearch(historyItem.query);
                      },
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
