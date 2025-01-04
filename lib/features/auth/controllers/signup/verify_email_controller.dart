import 'dart:async';
import 'package:ecom_app/common/widgets/success_screen/success_screen.dart';
import 'package:ecom_app/data/repositories/authentication/authentication_repositories.dart';
import 'package:ecom_app/utils/constaints/image_string.dart';
import 'package:ecom_app/utils/constaints/text_string.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';

import '../../../../common/widgets/loaders/loaders.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  // send email whenever verify screen appears and set time for auto redirect
  @override
  void onInit() {
    sendEmailVerification();
    setTimeToAutoRedirect();
    super.onInit();
  }

  sendEmailVerification() async {
    try {
      await AuthenticationRepositories.instance.sendEmailVerification();
      ELoader.successSnackBar(
          title: 'Email Sent!',
          message: 'Check your email to verify your account');
    } catch (e) {
      ELoader.errorSnackBar(
          title: 'Opp! Somthing went wrong.', message: e.toString());
    }
  }

  setTimeToAutoRedirect() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        await FirebaseAuth.instance.currentUser?.reload();
        final user = FirebaseAuth.instance.currentUser;
        if (user?.emailVerified ?? false) {
          timer.cancel();
          Get.off(() => SuccessScreen(
              image: EImages.verifyCheckEmailImage,
              title: ETexts.yourAccountCreatedTitle,
              subTitle: ETexts.yourAccountCreatedSubTitle,
              onPressed: () =>
                  AuthenticationRepositories.instance.screenRedirect()));
        }
      },
    );
  }

  // check if email verified
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(() => SuccessScreen(
          image: EImages.verifyCheckEmailImage,
          title: ETexts.yourAccountCreatedTitle,
          subTitle: ETexts.yourAccountCreatedSubTitle,
          onPressed: () =>
              AuthenticationRepositories.instance.screenRedirect()));
    }
  }
}
