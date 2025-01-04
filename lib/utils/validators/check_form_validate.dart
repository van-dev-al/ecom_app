import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../popups/full_screen_loader.dart';

class CheckFormValidate extends GetxController {
  GlobalKey<FormState> checkFormKey = GlobalKey<FormState>();

  Future<void> checkFormValidate() async {
    if (!checkFormKey.currentState!.validate()) {
      EFullScreenLoader.stoploading();
      return;
    }
  }
}
