import 'package:ecom_app/common/widgets/appbar/appbar.dart';
import 'package:ecom_app/features/pers/controllers/update_username_controller.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:ecom_app/utils/constaints/text_string.dart';
import 'package:ecom_app/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChangeUsername extends StatelessWidget {
  const ChangeUsername({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateUsernameController());

    return Scaffold(
      appBar: EAppBar(
        title:
            Text('Username', style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(ESizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // heading
            Text(
              'Change your username',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: ESizes.spaceBtwSeccions),

            // form change name
            Form(
                key: controller.updateUserNameFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.username,
                      validator: (value) =>
                          EValidator.validateEmptyText('Username', value!),
                      expands: false,
                      decoration: const InputDecoration(
                          labelText: ETexts.userName,
                          prefixIcon: Icon(Iconsax.user)),
                    ),
                  ],
                )),
            const SizedBox(height: ESizes.spaceBtwSeccions),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.updateUserName(),
                  child: const Text('Save')),
            )
          ],
        ),
      ),
    );
  }
}
