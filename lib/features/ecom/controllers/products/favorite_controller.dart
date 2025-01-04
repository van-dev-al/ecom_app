import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:crypto/crypto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/common/widgets/loaders/loaders.dart';
import 'package:ecom_app/data/repositories/authentication/authentication_repositories.dart';
import 'package:ecom_app/data/repositories/products/product_repository.dart';
import 'package:ecom_app/features/ecom/models/products/product_model.dart';
import 'package:ecom_app/utils/local_storage/storage_utility.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  static FavoriteController get instance => Get.find();

  final favorites = <String, bool>{}.obs;

  @override
  void onInit() {
    Get.put(ProductRepository());

    super.onInit();
    initFavorites();
    updateFavoriteProductPrices();
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

  Future<void> updateFavoriteProductPrices() async {
    String userId = AuthenticationRepositories.instance.authUser?.uid ?? "/";

    try {
      List<String> productUrls = favorites.keys.toList();

      if (productUrls.isEmpty) return;

      List<ProductModel> updatedProducts =
          await ProductRepository.instance.getProductByUrl(productUrls);

      for (var product in updatedProducts) {
        await FirebaseFirestore.instance
            .collection('PriceHistory')
            .doc(userId)
            .collection('history')
            .add({
          'price': product.price,
          'timestamp': FieldValue.serverTimestamp(),
          'productUrl': product.urls,
        });
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
