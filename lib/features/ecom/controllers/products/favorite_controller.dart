import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:crypto/crypto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/common/widgets/loaders/loaders.dart';
import 'package:ecom_app/data/repositories/authentication/authentication_repositories.dart';
import 'package:ecom_app/data/repositories/products/product_repository.dart';
import 'package:ecom_app/features/ecom/models/products/product_model.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:ecom_app/utils/formatters/formatter.dart';
import 'package:ecom_app/utils/local_storage/storage_utility.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  static FavoriteController get instance => Get.find();

  final favorites = <String, bool>{}.obs;

  @override
  void onInit() {
    Get.put(ProductRepository());

    super.onInit();
    initFavorites();
    // updateFavoriteProductPrices();
  }

  Future<void> initFavorites() async {
    final json = ELocalStorage.instance().readData('favorites');
    if (json != null) {
      final storedFavorites = jsonDecode(json) as Map<String, dynamic>;
      favorites.assignAll(
          storedFavorites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isFavorite(String productUrl) {
    return favorites[productUrl] ?? false;
  }

  String _generateHash(String input) {
    var bytes = utf8.encode(input);
    var digest = sha1.convert(bytes);
    return digest.toString();
  }

  void toggleFavoriteProduct(String productUrl) async {
    String userId = AuthenticationRepositories.instance.authUser?.uid ?? "/";
    String cleanedProductUrl = productUrl.replaceAll(RegExp(r'//'), '_');
    String hashedUrl = _generateHash(cleanedProductUrl);

    if (!favorites.containsKey(productUrl)) {
      favorites[productUrl] = true;
      saveFavoritesToStorage();
      ELoader.customToast(message: 'Product has been added to the Favorites!');

      try {
        await FirebaseFirestore.instance
            .collection('Favorites')
            .doc(userId)
            .collection('userFavorites')
            .doc(hashedUrl)
            .set({
          'url': productUrl,
          'userId': userId,
          'addedAt': FieldValue.serverTimestamp(),
        });
      } catch (e) {
        throw e.toString();
      }

      try {
        List<ProductModel> product =
            await ProductRepository.instance.getProductByUrl([productUrl]);

        if (product.isNotEmpty) {
          await FirebaseFirestore.instance
              .collection('PriceHistory')
              .doc(userId)
              .collection('history')
              .add({
            'price': product[0].price,
            'timestamp': FieldValue.serverTimestamp(),
            'productUrl': productUrl,
          });
        } else {
          if (kDebugMode) {
            print("No product data found for URL: $productUrl");
          }
        }
      } catch (e) {
        throw e.toString();
      }
    } else {
      favorites.remove(productUrl);
      saveFavoritesToStorage();
      favorites.refresh();
      ELoader.customToast(
          message: 'Product has been removed from the Favorites!');

      try {
        await FirebaseFirestore.instance
            .collection('Favorites')
            .doc(userId)
            .collection('userFavorites')
            .doc(hashedUrl)
            .delete();
      } catch (e) {
        throw e.toString();
      }
    }
  }

  void saveFavoritesToStorage() {
    final encodedFavorites = json.encode(favorites);
    ELocalStorage.instance().saveData('favorites', encodedFavorites);
  }

  Future<List<ProductModel>> favoriteProducts() async {
    return await ProductRepository.instance
        .getFavoriteProducts(favorites.keys.toList());
  }

  Future<List<Map<String, dynamic>>> getPriceHistory(String productUrl,
      {int limit = 5}) async {
    String userId = AuthenticationRepositories.instance.authUser?.uid ?? "/";

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('PriceHistory')
          .doc(userId)
          .collection('history')
          .where('productUrl', isEqualTo: productUrl)
          .orderBy('timestamp', descending: true)
          .limit(limit)
          .get();

      return querySnapshot.docs
          .map((doc) => {
                'price': doc['price'],
                'timestamp': doc['timestamp'],
              })
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> deletePriceHistory(String productUrl,
      {bool deleteAll = false}) async {
    String userId = AuthenticationRepositories.instance.authUser?.uid ?? "/";

    try {
      if (deleteAll) {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('PriceHistory')
            .doc(userId)
            .collection('history')
            .get();

        for (var doc in querySnapshot.docs) {
          await doc.reference.delete();
        }

        ELoader.customToast(message: 'All price history has been deleted!');
      } else {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('PriceHistory')
            .doc(userId)
            .collection('history')
            .where('productUrl', isEqualTo: productUrl)
            .get();

        for (var doc in querySnapshot.docs) {
          await doc.reference.delete();
        }

        ELoader.customToast(
            message: 'Price history for the product has been deleted!');
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> updateFavoriteProductPrices(BuildContext context) async {
    String userId = AuthenticationRepositories.instance.authUser?.uid ?? "/";

    try {
      List<String> productUrls = favorites.keys.toList();

      if (productUrls.isEmpty) return;

      List<ProductModel> updatedProducts =
          await ProductRepository.instance.getProductByUrl(productUrls);

      List<Map<String, dynamic>> discountedProducts = [];

      for (var product in updatedProducts) {
        QuerySnapshot priceHistorySnapshot = await FirebaseFirestore.instance
            .collection('PriceHistory')
            .doc(userId)
            .collection('history')
            .where('productUrl', isEqualTo: product.urls)
            .orderBy('timestamp', descending: true)
            .limit(1)
            .get();

        double? oldPrice;
        if (priceHistorySnapshot.docs.isNotEmpty) {
          var firstDoc =
              priceHistorySnapshot.docs.first.data() as Map<String, dynamic>;
          if (firstDoc.containsKey('price')) {
            oldPrice = firstDoc['price'] as double?;
          }
        }

        await FirebaseFirestore.instance
            .collection('PriceHistory')
            .doc(userId)
            .collection('history')
            .add({
          'price': product.price,
          'timestamp': FieldValue.serverTimestamp(),
          'productUrl': product.urls,
        });

        if (oldPrice != null && product.price < oldPrice) {
          discountedProducts.add({
            'name': product.name,
            'oldPrice': oldPrice,
            'newPrice': product.price,
            'url': product.urls,
          });
        }
      }

      if (discountedProducts.isNotEmpty) {
        await showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: const Text('Notification!'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: discountedProducts.map((product) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: ESizes.spaceBtwItems / 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Product in your price history: ${product['name']}',
                          maxLines: 2,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: ESizes.fontSizeMd),
                        ),
                        const SizedBox(height: ESizes.spaceBtwItems / 2),
                        Text('Price has changed:'),
                        Text(
                            'Old price: ${EFormatter.formatCurrency(product['oldPrice'])}',
                            style: TextStyle(color: Colors.red[700])),
                        Text(
                            'New price: ${EFormatter.formatCurrency(product['newPrice'])}',
                            style: TextStyle(color: Colors.green)),
                        Text(
                            'Savings: ${EFormatter.formatCurrency((product['oldPrice'] - product['newPrice']))}'),
                        const Divider(),
                      ],
                    ),
                  );
                }).toList(),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Close'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
