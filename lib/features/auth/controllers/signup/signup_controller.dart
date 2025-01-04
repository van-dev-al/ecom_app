import 'package:ecom_app/common/widgets/loaders/loaders.dart';
import 'package:ecom_app/data/repositories/authentication/authentication_repositories.dart';
import 'package:ecom_app/data/repositories/user/user_repositories.dart';
import 'package:ecom_app/data/services/netwotk_manager.dart';
import 'package:ecom_app/features/auth/screens/signup/verify_email.dart';
import 'package:ecom_app/features/pers/models/user_model.dart';
import 'package:ecom_app/utils/constaints/image_string.dart';
import 'package:ecom_app/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // variables
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  // final signupFormKey = GlobalKey<FormState>(debugLabel: 'signupForm');
  // final signupFormKey = GlobalKey<FormState>(debugLabel: 'signupForm');

  final hidePassword = true.obs;
  final privacy = true.obs;

  void signup() async {
    try {
      EFullScreenLoader.openLoadingDialog('Is professing ..', EImages.facebook);

      // check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        EFullScreenLoader.stoploading();
        return;
      }

      // check form signup
      if (!signupFormKey.currentState!.validate()) {
        EFullScreenLoader.stoploading();
        return;
      }

      // privacy check
      if (!privacy.value) {
        ELoader.warningSnackBar(
          title: 'Accept Privacy Policy',
          message:
              'To create an account. You must have to read and accept the Privacy & Policy',
        );
        EFullScreenLoader.stoploading();
        return;
      }

      final userCredential = await AuthenticationRepositories.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.toString().trim());

      final newUser = UserModel(
        id: userCredential.user!.uid,
        username: userName.text.trim(),
        email: email.text.trim(),
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
        gender: '',
        dateOfBirth: null,
      );
      final userRepositories = Get.put(UserRepositories());
      await userRepositories.saveUserRecord(newUser);

      EFullScreenLoader.stoploading();

      // show success message
      ELoader.successSnackBar(
          title: 'Congratulations!',
          message:
              'Your account has been created successfully! Verify email to continue');

      //
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));

      // if (kDebugMode) {
      //   print(
      //       '-----------------------GO TO VERIFI SCREEN-----------------------');
      // }
      //
    } catch (e) {
      EFullScreenLoader.stoploading();

      //
      ELoader.errorSnackBar(
          title: 'Opp! Somthing went wrong. adadsadaddasdsa',
          message: e.toString());
    }
  }
}
