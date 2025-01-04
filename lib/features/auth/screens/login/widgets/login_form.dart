import 'package:ecom_app/features/auth/controllers/login/login_controller.dart';
import 'package:ecom_app/features/auth/screens/password_configuration/forgot_password.dart';
import 'package:ecom_app/features/auth/screens/signup/signup.dart';
import 'package:ecom_app/utils/helpers/helper_funtions.dart';
import 'package:ecom_app/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constaints/colors.dart';
import '../../../../../utils/constaints/sizes.dart';
import '../../../../../utils/constaints/text_string.dart';

class ELoginForm extends StatelessWidget {
  const ELoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFuntions.isDarkMode(context);
    // final controller = Get.find<LoginController>();
    final controller = Get.put(LoginController());

    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: ESizes.spaceBtwSeccions),
        child: Column(
          children: [
            // Email
            TextFormField(
              controller: controller.email,
              validator: (value) => EValidator.validateEmail(value),
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: ETexts.email),
            ),
            const SizedBox(
              height: ESizes.spaceBtwInputFields,
            ),

            // Password
            Obx(
              () => TextFormField(
                controller: controller.password,
                validator: (value) => EValidator.validatePassword(value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  labelText: ETexts.password,
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                        !controller.hidePassword.value,
                    icon: Icon(controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: ESizes.spaceBtwInputFields / 2,
            ),

            // Remember me and forgot password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Remember me
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: (value) => controller.rememberMe.value =
                              !controller.rememberMe.value),
                    ),
                    const Text(ETexts.rememberMe),
                  ],
                ),
                // Forgot password
                TextButton(
                  onPressed: () => Get.to(() => const ForgotPassword()),
                  child: const Text(ETexts.forgotPassword),
                ),
              ],
            ),
            const SizedBox(
              height: ESizes.spaceBtwInputFields,
            ),

            // Sign in button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.emailAndPasswordSignin(),
                style: ElevatedButton.styleFrom(
                  side: BorderSide.none,
                  backgroundColor: dark ? EColors.primary : EColors.black,
                ),
                child: const Text(ETexts.signIn),
              ),
            ),
            const SizedBox(
              height: ESizes.spaceBtwItems,
            ),
            // Create account button
            SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () => Get.to(() => const SignUpScreen()),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                          color: dark ? EColors.grey : EColors.darkGrey),
                    ),
                    child: const Text(ETexts.createAccont))),
            // const SizedBox(
            //   height: ESizes.spaceBtwItems,
            // ),
          ],
        ),
      ),
    );
  }
}
