import 'package:ecom_app/common/widgets/appbar/appbar.dart';
import 'package:ecom_app/features/pers/controllers/update_password_controller.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:ecom_app/utils/constaints/text_string.dart';
import 'package:ecom_app/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdatePasswordController());

    return Scaffold(
      appBar: EAppBar(
        title: Text('Change Password',
            style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(ESizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // heading
            Text(
              'Change your password',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: ESizes.spaceBtwSeccions),

            // form change password
            Form(
                key: controller.updatePasswordFormKey,
                child: Column(
                  children: [
                    // Mật khẩu cũ
                    TextFormField(
                      controller: controller.oldPassword,
                      validator: (value) => EValidator.validatePassword(value),
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: ETexts.oldPassword,
                        prefixIcon: Icon(Iconsax.key),
                      ),
                    ),
                    const SizedBox(height: ESizes.spaceBtwInputFields),

                    // Mật khẩu mới
                    TextFormField(
                      controller: controller.newPassword,
                      validator: (value) =>
                          EValidator.validateEmptyText('New Password', value!),
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: ETexts.newPassword,
                        prefixIcon: Icon(Iconsax.lock),
                      ),
                    ),
                    const SizedBox(height: ESizes.spaceBtwInputFields),

                    // Xác nhận mật khẩu mới
                    TextFormField(
                      controller: controller.confirmPassword,
                      validator: (value) {
                        if (value != controller.newPassword.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: ETexts.confirmPassword,
                        prefixIcon: Icon(Iconsax.lock),
                      ),
                    ),
                  ],
                )),
            const SizedBox(height: ESizes.spaceBtwSeccions),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updatePassword(),
                child: const Text('Save'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
