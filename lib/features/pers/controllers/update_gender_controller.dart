import 'package:ecom_app/common/widgets/loaders/loaders.dart';
import 'package:ecom_app/data/repositories/user/user_repositories.dart';
import 'package:ecom_app/data/services/netwotk_manager.dart';
import 'package:ecom_app/features/pers/controllers/user_controller.dart';
import 'package:ecom_app/features/pers/screens/profile/profile.dart';
import 'package:ecom_app/utils/constaints/image_string.dart';
import 'package:ecom_app/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateGenderController extends GetxController {
  static UpdateGenderController get instance => Get.find();

  final genderController = TextEditingController();
  final userController = UserController.instance;
  final userRepositories = Get.put(UserRepositories());
  GlobalKey<FormState> updateGenderFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    initializeGender();
  }

  Future<void> initializeGender() async {
    genderController.text = userController.user.value.gender ?? 'Not set';
  }

  Future<void> updateGender() async {
    try {
      // loader
      EFullScreenLoader.openLoadingDialog(
          'Updating Gender ...', EImages.loaderImage);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        EFullScreenLoader.stoploading();
        return;
      }

      if (!updateGenderFormKey.currentState!.validate()) {
        EFullScreenLoader.stoploading();
        return;
      }

      Map<String, dynamic> gender = {
        'Gender': genderController.text.trim(),
      };

      await userRepositories.updateSingleField(gender);

      userController.user.value.gender = genderController.text.trim();

      EFullScreenLoader.stoploading();

      ELoader.successSnackBar(
          title: 'Congratulations!', message: 'Your Gender has been updated!');

      Get.off(() => const ProfileScreen());
    } catch (e) {
      EFullScreenLoader.stoploading();
      ELoader.errorSnackBar(
          title: 'Opp! Something went wrong.', message: e.toString());
    }
  }
}
