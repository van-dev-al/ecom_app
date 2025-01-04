import 'package:ecom_app/common/widgets/appbar/appbar.dart';
import 'package:ecom_app/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:ecom_app/common/widgets/list_titles/settings_menu_title.dart';
import 'package:ecom_app/common/widgets/list_titles/user_profile_title.dart';
import 'package:ecom_app/common/widgets/text/search_heading.dart';
import 'package:ecom_app/data/repositories/authentication/authentication_repositories.dart';
import 'package:ecom_app/features/pers/screens/profile/widgets/chane_password.dart';
import 'package:ecom_app/features/pers/screens/settings/widgets/price_history_screen.dart';
import 'package:ecom_app/features/pers/screens/settings/widgets/search_history_screen.dart';
import 'package:ecom_app/utils/constaints/colors.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:ecom_app/utils/helpers/helper_funtions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFuntions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // header
            EPrimaryHeaderContainer(
              child: Column(
                children: [
                  // appbar
                  EAppBar(
                    title: Text(
                      'Account',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: EColors.white),
                    ),
                  ),

                  // user profile card
                  const EUserProfileTitle(),
                  const SizedBox(height: ESizes.spaceBtwSeccions),
                ],
              ),
            ),

            // body
            Padding(
              padding: const EdgeInsets.all(ESizes.defaultSpace),
              child: Column(
                children: [
                  // account settings
                  const ESectionHeading(
                    title: 'Account Settings',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: ESizes.spaceBtwItems,
                  ),

                  ESettingsMenuTitle(
                    icon: Icons.history,
                    title: 'Price history',
                    subtitle: 'Something your history!',
                    onTap: () => Get.to(() => const EPriceHistoryScreen()),
                  ),

                  ESettingsMenuTitle(
                    icon: Icons.history,
                    title: 'Search history',
                    subtitle: 'Something your history!',
                    onTap: () => Get.to(() => const ESearchHistoryScreen()),
                  ),

                  ESettingsMenuTitle(
                    icon: Iconsax.password_check,
                    title: 'Change your password',
                    subtitle: 'Something your password!',
                    onTap: () => Get.to(() => const ChangePassword()),
                  ),

                  const SizedBox(height: ESizes.spaceBtwSeccions),

                  // logout button
                  const SizedBox(height: ESizes.spaceBtwSeccions),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () =>
                          AuthenticationRepositories.instance.logoutLogin(),
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              color: dark ? EColors.grey : EColors.black)),
                      child: const Text('Logout'),
                    ),
                  ),
                  const SizedBox(height: ESizes.spaceBtwSeccions),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
