import 'package:ecom_app/common/widgets/appbar/appbar.dart';
import 'package:ecom_app/features/pers/controllers/update_name_controller.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:ecom_app/utils/constaints/text_string.dart';
import 'package:ecom_app/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());

    return Scaffold(
      appBar: EAppBar(
        title: Text('Name', style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(ESizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // heading
            Text(
              'Change your name',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: ESizes.spaceBtwSeccions),

            // form change name
            Form(
                key: controller.updateUserNameFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.firstName,
                      validator: (value) =>
                          EValidator.validateEmptyText('First Name', value!),
                      expands: false,
                      decoration: const InputDecoration(
                          labelText: ETexts.firstName,
                          prefixIcon: Icon(Iconsax.user)),
                    ),
                    const SizedBox(height: ESizes.spaceBtwInputFields),
                    TextFormField(
                      controller: controller.lastName,
                      validator: (value) =>
                          EValidator.validateEmptyText('Last Name', value!),
                      expands: false,
                      decoration: const InputDecoration(
                          labelText: ETexts.lastName,
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
