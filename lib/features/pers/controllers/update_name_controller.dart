import 'package:ecom_app/common/widgets/loaders/loaders.dart';
import 'package:ecom_app/data/repositories/user/user_repositories.dart';
import 'package:ecom_app/data/services/netwotk_manager.dart';
import 'package:ecom_app/features/pers/controllers/user_controller.dart';
import 'package:ecom_app/features/pers/screens/profile/profile.dart';
import 'package:ecom_app/utils/constaints/image_string.dart';
import 'package:ecom_app/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepositories = Get.put(UserRepositories());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    initializeName();
  }

  Future<void> initializeName() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      // loader
      EFullScreenLoader.openLoadingDialog(
          'Updating information ..', EImages.loaderImage);

      // check intternet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        EFullScreenLoader.stoploading();
        return;
      }

      //form validate
      if (!updateUserNameFormKey.currentState!.validate()) {
        EFullScreenLoader.stoploading();
        return;
      }

      // update user first name and last name in the firebase storage
      Map<String, dynamic> name = {
        'FirstName': firstName.text.trim(),
        'LastName': lastName.text.trim()
      };
      await userRepositories.updateSingleField(name);

      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      EFullScreenLoader.stoploading();

      ELoader.successSnackBar(
          title: 'Congratulations!', message: 'Your name has been updated!');

      Get.off(() => const ProfileScreen());
    } catch (e) {
      EFullScreenLoader.stoploading();

      ELoader.errorSnackBar(
          title: 'Opp! Something went wrong.', message: e.toString());
    }
  }
}
