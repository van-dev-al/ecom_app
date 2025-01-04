import 'package:ecom_app/common/widgets/loaders/loaders.dart';
import 'package:ecom_app/data/repositories/authentication/authentication_repositories.dart';
import 'package:ecom_app/data/services/netwotk_manager.dart';
import 'package:ecom_app/features/auth/screens/password_configuration/reset_password.dart';
import 'package:ecom_app/utils/constaints/image_string.dart';
import 'package:ecom_app/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  static ForgotPasswordController get instance => Get.find();

  final email = TextEditingController();
  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();

  senddPasswordResetEmail() async {
    try {
      //
      EFullScreenLoader.openLoadingDialog(
          'Processing your request ..', EImages.loaderImage);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        EFullScreenLoader.stoploading();
        return;
      }

      if (!forgotPasswordFormKey.currentState!.validate()) {
        EFullScreenLoader.stoploading();
        return;
      }

      await AuthenticationRepositories.instance
          .sendPasswordResetEmail(email.text.trim());

      EFullScreenLoader.stoploading();

      ELoader.successSnackBar(
          title: 'Email sent!',
          message: 'Email link sent to Reset your password.');

      //
      Get.to(() => ResetPasswordScreen(email: email.text.trim()));
      //
    } catch (e) {
      //
      EFullScreenLoader.stoploading();
      ELoader.errorSnackBar(
          title: 'Opp! Something went wrong.', message: e.toString());
    }
  }

  resenddPasswordResetEmail(String email) async {
    try {
      //
      EFullScreenLoader.openLoadingDialog(
          'Processing your request ..', EImages.loaderImage);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        EFullScreenLoader.stoploading();
        return;
      }

      await AuthenticationRepositories.instance.sendPasswordResetEmail(email);

      EFullScreenLoader.stoploading();

      ELoader.successSnackBar(
          title: 'Email sent!',
          message: 'Email link sent to Reset your password.');
    } catch (e) {
      //
      EFullScreenLoader.stoploading();
      ELoader.errorSnackBar(
          title: 'Opp! Something went wrong.', message: e.toString());
    }
  }
}
