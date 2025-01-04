import 'package:ecom_app/features/auth/controllers/forgot_password/forgot_password_controller.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:ecom_app/utils/constaints/text_string.dart';
import 'package:ecom_app/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgotPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(ESizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // header
            Text(
              ETexts.forgotPasswordTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: ESizes.spaceBtwItems,
            ),
            Text(
              ETexts.forgotPasswordSubTitle,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(
              height: ESizes.spaceBtwSeccions * 2,
            ),

            // text field
            Form(
              key: controller.forgotPasswordFormKey,
              child: TextFormField(
                controller: controller.email,
                validator: (value) => EValidator.validateEmail(value),
                decoration: const InputDecoration(
                    labelText: ETexts.email,
                    prefixIcon: Icon(Iconsax.direct_right)),
              ),
            ),
            const SizedBox(
              height: ESizes.spaceBtwSeccions,
            ),

            // submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.senddPasswordResetEmail(),
                child: const Text(ETexts.eSubmit),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
