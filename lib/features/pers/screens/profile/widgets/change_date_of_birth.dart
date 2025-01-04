import 'package:ecom_app/common/widgets/appbar/appbar.dart';
import 'package:ecom_app/features/pers/controllers/update_date_of_birth_controller.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:ecom_app/utils/constaints/text_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:iconsax/iconsax.dart';

class ChangeDateOfBirth extends StatelessWidget {
  const ChangeDateOfBirth({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put(UpdateDateOfBirthController()); // Hoặc controller của bạn

    return Scaffold(
      appBar: EAppBar(
        title: Text('Date of Birth',
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
              'Change your Date of Birth',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: ESizes.spaceBtwSeccions),

            // form change date of birth
            Form(
              key: controller
                  .updateDateOfBirthFormKey, // Update key nếu cần thiết
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.dateOfBirthController,
                    validator: (value) {
                      // Kiểm tra xem người dùng có chọn ngày hợp lệ hay không
                      if (value == null ||
                          value.isEmpty ||
                          value == 'Not set') {
                        return 'Please select a valid date of birth';
                      }
                      return null;
                    },
                    readOnly:
                        true, // Người dùng không nhập trực tiếp, chỉ chọn ngày
                    onTap: () async {
                      // Mở DatePicker
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate:
                            controller.userController.user.value.dateOfBirth ??
                                DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null) {
                        // Định dạng lại ngày chọn
                        String formattedDate =
                            DateFormat('d MMM, yyyy').format(pickedDate);
                        controller.dateOfBirthController.text =
                            formattedDate; // Cập nhật ngày chọn
                      }
                    },
                    decoration: const InputDecoration(
                        labelText: ETexts.dateOfBirth,
                        prefixIcon: Icon(Iconsax.calendar)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: ESizes.spaceBtwSeccions),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updateDateOfBirth(),
                child: const Text('Save'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
