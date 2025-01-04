import 'package:ecom_app/common/widgets/appbar/appbar.dart';
import 'package:ecom_app/common/widgets/images/circular_image.dart';
import 'package:ecom_app/common/widgets/text/search_heading.dart';
import 'package:ecom_app/features/pers/controllers/update_profile_picture_controller.dart';
import 'package:ecom_app/features/pers/controllers/user_controller.dart';
import 'package:ecom_app/features/pers/screens/profile/widgets/change_date_of_birth.dart';
import 'package:ecom_app/features/pers/screens/profile/widgets/change_gender.dart';
import 'package:ecom_app/features/pers/screens/profile/widgets/change_name.dart';
import 'package:ecom_app/features/pers/screens/profile/widgets/change_phone_number.dart';
import 'package:ecom_app/features/pers/screens/profile/widgets/change_username.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:ecom_app/utils/formatters/formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import 'widgets/profile_menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    final profilePictureController = Get.put(UpdateProfileController());
    return Scaffold(
      appBar: const EAppBar(
        showBackArrow: true,
        title: Text('Profile'),
      ),
      // body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            children: [
              // profile picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      if (profilePictureController
                          .profileImageUrl.value.isEmpty) {
                        return CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                              profilePictureController.profileImageUrl.value),
                        );
                      } else {
                        return ECircularImage(
                            padding: ESizes.zero,
                            borderRadius: 50,
                            image:
                                profilePictureController.profileImageUrl.value,
                            isNetworkImage: true,
                            width: 80,
                            height: 80);
                      }
                    }),
                    TextButton(
                        onPressed: () async {
                          await profilePictureController.pickImage();
                        },
                        child: const Text('Change Profile Picture')),
                  ],
                ),
              ),

              // details
              const SizedBox(height: ESizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: ESizes.spaceBtwItems),

              // heading profile info
              const ESectionHeading(
                  title: 'Profile information', showActionButton: false),
              const SizedBox(height: ESizes.spaceBtwItems),

              EProfileMenu(
                onPressed: () => Get.to(() => const ChangeName()),
                title: 'Name:',
                value: controller.user.value.fullName,
              ),
              EProfileMenu(
                onPressed: () => Get.to(() => const ChangeUsername()),
                title: 'Username:',
                value: controller.user.value.username,
              ),

              const SizedBox(height: ESizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: ESizes.spaceBtwItems),

              // heading persional info
              const ESectionHeading(
                  title: 'Profile information', showActionButton: false),
              const SizedBox(height: ESizes.spaceBtwItems),

              EProfileMenu(
                onPressed: () async {
                  await copyUserIDToClipboard(context);
                },
                title: 'User ID:',
                value: controller.user.value.id,
                icon: Iconsax.copy,
              ),
              EProfileMenu(
                onPressed: () {},
                title: 'Email:',
                value: controller.user.value.email,
              ),
              EProfileMenu(
                onPressed: () => Get.to(() => const ChangePhoneNumber()),
                title: 'Phone Number:',
                value: EFormatter.formatPhoneNumber(
                    controller.user.value.phoneNumber),
              ),
              EProfileMenu(
                onPressed: () => Get.to(() => const ChangeGender()),
                title: 'Gender:',
                value: controller.user.value.gender ?? '',
              ),
              EProfileMenu(
                onPressed: () => Get.to(() => const ChangeDateOfBirth()),
                title: 'Date of Birth:',
                value: controller.user.value.dateOfBirth != null
                    ? DateFormat('d MMM, yyyy')
                        .format(controller.user.value.dateOfBirth!)
                    : 'Not set',
              ),
              const SizedBox(height: ESizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: ESizes.spaceBtwItems),

              // delete account button
              Center(
                child: TextButton(
                    onPressed: () => controller.deleteAccountWarningPopups(),
                    child: const Text(
                      'Delete Account',
                      style: TextStyle(color: Colors.red),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> copyUserIDToClipboard(BuildContext context) async {
    final controller = UserController.instance;
    await Clipboard.setData(ClipboardData(text: controller.user.value.id));
  }
}
