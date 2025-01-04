import 'package:ecom_app/features/auth/screens/login/login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  // Variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  // Update Current index when page scroll
  void updatePageIndicator(index) => currentPageIndex.value = index;

  // Jump to specific dot selected page
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  // Update current index and jump to next page
  void nextPage() {
    if (currentPageIndex.value == 2) {
      final storage = GetStorage();
      storage.write('isFirstTime', false);
      if (kDebugMode) {
        print("---------------- GET STORAGE NEXT BUTTON ----------------");
        print(storage.read('isFirstTime'));
      }
      Get.offAll(const LoginScreen());
    } else {
      int page = currentPageIndex.value + 1;
      pageController.animateToPage(page,
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    }
  }

  // Update current index and jump to the last page
  void skipPage() {
    currentPageIndex.value = 2;
    pageController.animateToPage(2,
        duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
  }
}
