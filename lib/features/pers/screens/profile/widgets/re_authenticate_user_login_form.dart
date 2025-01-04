import 'package:ecom_app/features/pers/controllers/user_controller.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:ecom_app/utils/constaints/text_string.dart';
import 'package:ecom_app/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ReAuthenticateUserLoginForm extends StatelessWidget {
  const ReAuthenticateUserLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController();

    return Scaffold(
      appBar: AppBar(title: const Text('Re-auth User')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: Form(
            key: controller.reAuthFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: controller.verifyEmail,
                  validator: (value) => EValidator.validateEmail(value),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.direct_right),
                      labelText: ETexts.email),
                ),
                const SizedBox(height: ESizes.spaceBtwSeccions),
                Obx(
                  () => TextFormField(
                      obscureText: controller.hidePassword.value,
                      controller: controller.verifyPassword,
                      validator: (value) => EValidator.validatePassword(value),
                      decoration: InputDecoration(
                          labelText: ETexts.password,
                          prefixIcon: const Icon(Iconsax.password_check),
                          suffixIcon: IconButton(
                              onPressed: () => controller.hidePassword.value =
                                  !controller.hidePassword.value,
                              icon: const Icon(Iconsax.eye_slash)))),
                ),
                const SizedBox(height: ESizes.spaceBtwSeccions),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () =>
                          controller.reAuthenticateEmailAndPasswordUser(),
                      child: const Text('Verify')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
