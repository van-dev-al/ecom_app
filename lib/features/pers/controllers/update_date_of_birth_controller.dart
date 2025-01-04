import 'package:ecom_app/common/widgets/loaders/loaders.dart';
import 'package:ecom_app/data/repositories/user/user_repositories.dart';
import 'package:ecom_app/data/services/netwotk_manager.dart';
import 'package:ecom_app/features/pers/controllers/user_controller.dart';
import 'package:ecom_app/features/pers/screens/profile/profile.dart';
import 'package:ecom_app/utils/constaints/image_string.dart';
import 'package:ecom_app/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UpdateDateOfBirthController extends GetxController {
  static UpdateDateOfBirthController get instance => Get.find();

  final dateOfBirthController = TextEditingController();
  final userController = UserController.instance;
  final userRepositories = Get.put(UserRepositories());
  GlobalKey<FormState> updateDateOfBirthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    initializeDateOfBirth();
  }

  Future<void> initializeDateOfBirth() async {
    dateOfBirthController.text = userController.user.value.dateOfBirth != null
        ? DateFormat('d MMM, yyyy')
            .format(userController.user.value.dateOfBirth!)
        : 'Not set'; // Hiển thị 'Not set' nếu ngày sinh chưa có
  }

  // Hàm cập nhật ngày sinh
  Future<void> updateDateOfBirth() async {
    try {
      // loader
      EFullScreenLoader.openLoadingDialog(
          'Updating Date of Birth ...', EImages.loaderImage);

      // Kiểm tra kết nối internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        EFullScreenLoader.stoploading();
        return;
      }

      // Validate form
      if (!updateDateOfBirthFormKey.currentState!.validate()) {
        EFullScreenLoader.stoploading();
        return;
      }

      // Chuyển đổi text thành DateTime
      DateTime? selectedDate =
          DateFormat('d MMM, yyyy').parse(dateOfBirthController.text);
      Map<String, dynamic> dateOfBirth = {
        'DateOfBirth': selectedDate.toIso8601String(),
      };

      // Cập nhật ngày sinh trong Firebase
      await userRepositories.updateSingleField(dateOfBirth);

      // Cập nhật giá trị trong controller
      userController.user.value.dateOfBirth = selectedDate;

      EFullScreenLoader.stoploading();

      ELoader.successSnackBar(
          title: 'Congratulations!',
          message: 'Your Date of Birth has been updated!');

      Get.off(() => const ProfileScreen());
    } catch (e) {
      EFullScreenLoader.stoploading();
      ELoader.errorSnackBar(
          title: 'Opp! Something went wrong.', message: e.toString());
    }
  }
}
