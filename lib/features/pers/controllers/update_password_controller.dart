import 'package:ecom_app/common/widgets/loaders/loaders.dart';
import 'package:ecom_app/features/pers/screens/settings/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdatePasswordController extends GetxController {
  final oldPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();
  final GlobalKey<FormState> updatePasswordFormKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> updatePassword() async {
    if (!updatePasswordFormKey.currentState!.validate()) {
      return;
    }

    try {
      final user = _auth.currentUser;

      final credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: oldPassword.text,
      );

      await user.reauthenticateWithCredential(credential);

      if (newPassword.text != confirmPassword.text) {
        Get.snackbar('Error', 'Passwords do not match');
        return;
      }

      await user.updatePassword(newPassword.text);

      ELoader.successSnackBar(
          title: 'Congratulations!',
          message: 'Your Password has been updated!');

      Get.off(() => const SettingsScreen());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        Get.snackbar('Error', 'Incorrect old password');
      } else {
        Get.snackbar('Error', 'Failed to update password: ${e.message}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong. Please try again');
    }
  }
}
