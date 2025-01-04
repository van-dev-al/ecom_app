import 'package:ecom_app/common/widgets/appbar/appbar.dart';
import 'package:ecom_app/features/pers/controllers/update_gender_controller.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:ecom_app/utils/constaints/text_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeGender extends StatelessWidget {
  const ChangeGender({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateGenderController());

    return Scaffold(
      appBar: EAppBar(
        title: Text('Gender', style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(ESizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // heading
            Text(
              'Change your Gender',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: ESizes.spaceBtwSeccions),

            Form(
              key: controller.updateGenderFormKey,
              child: Column(
                children: [
                  // DropdownButton để chọn giới tính
                  DropdownButtonFormField<String>(
                    value: controller.genderController.text.isEmpty
                        ? null // Gán giá trị null thay vì ''
                        : controller.genderController.text,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        controller.genderController.text = newValue;
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: ETexts.gender,
                      prefixIcon: Icon(Icons.person),
                    ),
                    items: <String>['Male', 'Female', 'Other']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a gender';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: ESizes.spaceBtwSeccions),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updateGender(),
                child: const Text('Save'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
