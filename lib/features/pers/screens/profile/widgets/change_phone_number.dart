import 'package:ecom_app/common/widgets/appbar/appbar.dart';
import 'package:ecom_app/features/pers/controllers/update_phone_number_controller.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:ecom_app/utils/constaints/text_string.dart';
import 'package:ecom_app/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChangePhoneNumber extends StatelessWidget {
  const ChangePhoneNumber({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdatePhoneNumberController());

    return Scaffold(
      appBar: EAppBar(
        title: Text('Phone Number',
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
              'Change your phone number',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: ESizes.spaceBtwSeccions),

            // form change name
            Form(
                key: controller.updateUserNameFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.phonenumber,
                      validator: (value) =>
                          EValidator.validatePhoneNumber(value),
                      expands: false,
                      decoration: const InputDecoration(
                          labelText: ETexts.phoneNum,
                          prefixIcon: Icon(Iconsax.user)),
                    ),
                  ],
                )),
            const SizedBox(height: ESizes.spaceBtwSeccions),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.updatePhoneNumber(),
                  child: const Text('Save')),
            )
          ],
        ),
      ),
    );
  }
}
