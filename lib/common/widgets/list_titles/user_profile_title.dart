import 'package:ecom_app/common/widgets/images/circular_image.dart';
import 'package:ecom_app/common/widgets/shimmers/shimmer.dart';
import 'package:ecom_app/features/pers/controllers/update_profile_picture_controller.dart';
import 'package:ecom_app/features/pers/controllers/user_controller.dart';
import 'package:ecom_app/features/pers/screens/profile/profile.dart';
import 'package:ecom_app/utils/constaints/colors.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EUserProfileTitle extends StatelessWidget {
  const EUserProfileTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    final profilePictureController = Get.put(UpdateProfileController());
    return ListTile(
      leading: Obx(() {
        return profilePictureController.profileImageUrl.value.isEmpty
            ? const EShimmerEffect(width: 56, height: 56, radius: 40)
            : ECircularImage(
                borderRadius: 50,
                width: 56,
                height: 56,
                padding: ESizes.zero,
                backgroundColor: Colors.transparent,
                image: profilePictureController.profileImageUrl.value,
                isNetworkImage: true,
              );
      }),
      title: Text(
        controller.user.value.fullName,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: EColors.white),
      ),
      subtitle: Text(
        controller.user.value.email,
        style:
            Theme.of(context).textTheme.bodyMedium!.apply(color: EColors.white),
      ),
      trailing: IconButton(
          onPressed: () => Get.to(() => const ProfileScreen()),
          icon: const Icon(
            Iconsax.edit,
            color: EColors.white,
          )),
    );
  }
}
