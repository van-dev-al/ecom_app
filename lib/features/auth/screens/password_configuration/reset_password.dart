import 'package:ecom_app/features/auth/controllers/forgot_password/forgot_password_controller.dart';
import 'package:ecom_app/features/auth/screens/login/login.dart';
import 'package:ecom_app/utils/constaints/image_string.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:ecom_app/utils/constaints/text_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/helpers/helper_funtions.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                icon: const Icon(CupertinoIcons.clear),
                onPressed: () => Get.back()),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(ESizes.defaultSpace),
            child: Column(
              children: [
                // Image
                Image(
                  width: EHelperFuntions.screenWidth() * 0.6,
                  image: const AssetImage(EImages.verifyCheckEmailImage),
                ),
                const SizedBox(
                  height: ESizes.spaceBtwSeccions,
                ),

                //emai, title and subtitle
                Text(email,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center),
                const SizedBox(
                  height: ESizes.spaceBtwItems,
                ),
                Text(
                  ETexts.changeYourPasswordTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: ESizes.spaceBtwItems,
                ),
                Text(
                  ETexts.changeYourPasswordSubTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: ESizes.spaceBtwSeccions,
                ),
                // button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.offAll(() => const LoginScreen()),
                    child: const Text(ETexts.eDone),
                  ),
                ),
                const SizedBox(
                  height: ESizes.spaceBtwItems,
                ),
                // button
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => ForgotPasswordController.instance
                        .resenddPasswordResetEmail(email),
                    child: const Text(ETexts.resendEmail),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
