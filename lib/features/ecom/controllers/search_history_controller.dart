import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/data/repositories/authentication/authentication_repositories.dart';
import 'package:ecom_app/features/ecom/models/search_history_model.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:ecom_app/utils/helpers/helper_funtions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchHistoryController extends GetxController {
  static SearchHistoryController get instance => Get.find();

  final RxBool isLoading = false.obs;
  final RxList<SearchHistoryModel> searchHistory = <SearchHistoryModel>[].obs;

  final String userId =
      AuthenticationRepositories.instance.authUser?.uid ?? "/";

  Future<void> fetchSearchHistory() async {
    try {
      isLoading.value = true;

      final querySnapshot = await FirebaseFirestore.instance
          .collection('SearchHistory')
          .doc(userId)
          .collection('history')
          .orderBy('timestamp', descending: true)
          .get();

      final history = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return SearchHistoryModel.fromSnapshot(data);
      }).toList();

      searchHistory.assignAll(history);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch search history: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteSearchHistory(String queryId) async {
    try {
      await FirebaseFirestore.instance
          .collection('SearchHistory')
          .doc(userId)
          .collection('history')
          .doc(queryId)
          .delete();

      searchHistory.removeWhere((item) => item.query == queryId);
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete search history: $e');
    }
  }

  Future<void> deleteAllSearchHistory() async {
    try {
      final collectionRef = FirebaseFirestore.instance
          .collection('SearchHistory')
          .doc(userId)
          .collection('history');

      final querySnapshot = await collectionRef.get();

      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }

      searchHistory.clear();
      Get.snackbar('Success', 'All search history has been deleted.');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete all search history: $e');
    }
  }

  void deleteAllSearchHistoryWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(ESizes.md),
      title: 'Delete All Search History',
      middleText: 'Are you sure you want to delete all your search history?',
      backgroundColor: EHelperFuntions.isDarkMode(Get.context!)
          ? Colors.lightBlue[900]
          : Colors.white,
      confirm: ElevatedButton(
        onPressed: () async {
          await deleteAllSearchHistory();
          Get.back(); // Đóng popup sau khi xóa
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: ESizes.lg),
          child: Text('Delete'),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: const Text('Cancel'),
      ),
    );
  }
}
