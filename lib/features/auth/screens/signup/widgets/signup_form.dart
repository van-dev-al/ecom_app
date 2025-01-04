import 'package:ecom_app/features/auth/controllers/signup/signup_controller.dart';
import 'package:ecom_app/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constaints/sizes.dart';
import '../../../../../utils/constaints/text_string.dart';
import 'terms_and_conditons_form.dart';

class ESignupForm extends StatelessWidget {
  const ESignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());

    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) =>
                      EValidator.validateEmptyText('First Name', value!),
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: ETexts.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              const SizedBox(
                width: ESizes.spaceBtwInputFields,
              ),
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      EValidator.validateEmptyText('Last Name', value!),
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: ETexts.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: ESizes.spaceBtwInputFields,
          ),
          // username
          TextFormField(
            controller: controller.userName,
            validator: (value) =>
                EValidator.validateEmptyText('User Name', value!),
            expands: false,
            decoration: const InputDecoration(
              labelText: ETexts.userName,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          const SizedBox(
            height: ESizes.spaceBtwInputFields,
          ),

          // email
          TextFormField(
            controller: controller.email,
            validator: (value) => EValidator.validateEmail(value),
            decoration: const InputDecoration(
              labelText: ETexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(
            height: ESizes.spaceBtwInputFields,
          ),

          // phone number
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => EValidator.validatePhoneNumber(value),
            decoration: const InputDecoration(
              labelText: ETexts.phoneNum,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const SizedBox(
            height: ESizes.spaceBtwInputFields,
          ),

          // password
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
            height: ESizes.spaceBtwSeccions,
          ),

          // terms and conditions check box
          const ETermsAndConditionCheckBox(),
          const SizedBox(
            height: ESizes.spaceBtwSeccions,
          ),

          // sign up button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: const Text(ETexts.createAccont),
            ),
          ),
        ],
      ),
    );
  }
}
