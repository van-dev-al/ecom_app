import 'package:ecom_app/utils/constaints/colors.dart';
import 'package:ecom_app/utils/helpers/helper_funtions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/widgets/loaders/animation_loader.dart';

class EFullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => PopScope(
            canPop: false,
            child: Container(
              color: EHelperFuntions.isDarkMode(Get.context!)
                  ? EColors.dark
                  : EColors.white,
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 250),
                    EAnimationLoaderWidget(
                      text: text,
                      animaton: animation,
                    )
                  ],
                ),
              ),
            )));
  }

  static stoploading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
