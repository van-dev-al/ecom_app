import 'package:ecom_app/common/widgets/appbar/appbar.dart';
import 'package:ecom_app/features/ecom/controllers/search_history_controller.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ESearchHistoryScreen extends StatefulWidget {
  const ESearchHistoryScreen({super.key});

  @override
  State<ESearchHistoryScreen> createState() => ESearchHistoryScreenState();
}

class ESearchHistoryScreenState extends State<ESearchHistoryScreen> {
  final controller = SearchHistoryController.instance;

  @override
  void initState() {
    super.initState();
    controller.fetchSearchHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EAppBar(
        title: Text('Search history',
            style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(ESizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // heading
            Text(
              'Your Search history',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: ESizes.spaceBtwSeccions),
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                    child: Column(
                  children: [
                    SizedBox(height: ESizes.spaceBtwItems),
                    CircularProgressIndicator(),
                  ],
                ));
              }

              if (controller.searchHistory.isEmpty) {
                return Center(
                  child: Text(
                    'No search history available.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                );
              }

              return Expanded(
                child: ListView.separated(
                  itemCount: controller.searchHistory.length,
                  separatorBuilder: (context, index) => const Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  itemBuilder: (context, index) {
                    final historyItem = controller.searchHistory[index];

                    return ListTile(
                      leading: const Icon(Icons.history),
                      title: Text(
                        historyItem.query,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      subtitle: Text(
                        'Searched on ${historyItem.timestamp}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          controller.deleteSearchHistory(historyItem.query);
                        },
                      ),
                    );
                  },
                ),
              );
            }),
            const SizedBox(height: ESizes.spaceBtwSeccions),
            Center(
              child: TextButton(
                  onPressed: () =>
                      controller.deleteAllSearchHistoryWarningPopup(),
                  child: const Text(
                    'Delete All Search history?',
                    style: TextStyle(color: Colors.red),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
