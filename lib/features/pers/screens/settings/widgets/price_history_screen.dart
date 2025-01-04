import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/common/widgets/appbar/appbar.dart';
import 'package:ecom_app/common/widgets/images/rounded_image.dart';
import 'package:ecom_app/features/ecom/controllers/products/favorite_controller.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:ecom_app/utils/formatters/formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ecom_app/features/ecom/models/products/product_model.dart';

class EPriceHistoryScreen extends StatefulWidget {
  const EPriceHistoryScreen({super.key});

  @override
  State<EPriceHistoryScreen> createState() => EPriceHistoryScreenState();
}

class EPriceHistoryScreenState extends State<EPriceHistoryScreen> {
  final favoriteController = FavoriteController.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EAppBar(
        title: Text(
          'Price History',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(ESizes.spaceBtwItems),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Your Price History',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            const SizedBox(height: ESizes.spaceBtwSeccions),
            FutureBuilder<List<ProductModel>>(
              future: favoriteController.favoriteProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No favorite products found.'),
                  );
                }

                final products = snapshot.data!;

                return Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding:
                              const EdgeInsets.all(ESizes.spaceBtwItems / 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                leading: ERoundedImage(
                                  width: 56,
                                  height: 56,
                                  isNetworkImage: true,
                                  imageUrl: product.thumbnail,
                                ),
                                title: Text(
                                  product.name,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: ESizes.fontSizeMd,
                                  ),
                                ),
                                subtitle: Text(
                                  "Price: ${EFormatter.formatCurrency(product.price)}",
                                  style: const TextStyle(
                                      fontSize: ESizes.fontSizeSm),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () async {
                                    await favoriteController
                                        .deletePriceHistory(product.urls);
                                    setState(() {});
                                  },
                                ),
                              ),
                              FutureBuilder<List<Map<String, dynamic>>>(
                                future: favoriteController.getPriceHistory(
                                  product.urls,
                                  limit: 5,
                                ),
                                builder: (context, historySnapshot) {
                                  if (historySnapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Padding(
                                      padding: EdgeInsets.all(
                                          ESizes.spaceBtwItems / 2),
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (historySnapshot.hasError) {
                                    return Padding(
                                      padding: const EdgeInsets.all(
                                          ESizes.spaceBtwItems / 2),
                                      child: Text(
                                        'Error fetching history: ${historySnapshot.error}',
                                      ),
                                    );
                                  }
                                  final priceHistory =
                                      historySnapshot.data ?? [];

                                  final minPrice = priceHistory.isNotEmpty
                                      ? priceHistory
                                          .map((history) =>
                                              double.tryParse(history['price']
                                                  .toString()) ??
                                              double.infinity)
                                          .reduce((a, b) => a < b ? a : b)
                                      : null;

                                  return ExpansionTile(
                                    title: const Text(
                                      'Price History',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    children: priceHistory.isEmpty
                                        ? [
                                            const Padding(
                                              padding: EdgeInsets.all(
                                                  ESizes.spaceBtwItems / 2),
                                              child: Text(
                                                  'No price history available.'),
                                            ),
                                          ]
                                        : priceHistory.map((history) {
                                            final price =
                                                history['price'] ?? 'N/A';
                                            final timestamp =
                                                (history['timestamp']
                                                        as Timestamp)
                                                    .toDate();
                                            final formattedDate =
                                                DateFormat.yMMMd()
                                                    .add_jm()
                                                    .format(timestamp);

                                            final priceColor = (minPrice !=
                                                        null &&
                                                    double.tryParse(
                                                            price.toString()) ==
                                                        minPrice)
                                                ? Colors.green
                                                : Colors.black;

                                            return ListTile(
                                              title: Text(
                                                'Price: ${EFormatter.formatCurrency(price)}',
                                                style: TextStyle(
                                                    color: priceColor),
                                              ),
                                              subtitle:
                                                  Text('Date: $formattedDate'),
                                            );
                                          }).toList(),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: ESizes.spaceBtwItems),
            Center(
              child: TextButton(
                  onPressed: () async {
                    await favoriteController.deletePriceHistory('',
                        deleteAll: true);
                    setState(() {});
                  },
                  child: const Text(
                    'Delete All Price history?',
                    style: TextStyle(color: Colors.red),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
