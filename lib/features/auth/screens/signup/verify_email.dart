import 'package:ecom_app/data/repositories/authentication/authentication_repositories.dart';
import 'package:ecom_app/features/auth/controllers/signup/verify_email_controller.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:ecom_app/utils/constaints/text_string.dart';
import 'package:ecom_app/utils/helpers/helper_funtions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constaints/image_string.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({
    super.key,
    this.email,
  });

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => AuthenticationRepositories.instance.logout(),
            icon: const Icon(CupertinoIcons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            children: [
              // Image
              Image(
                width: EHelperFuntions.screenWidth() * 0.6,
                image: const AssetImage(EImages.verifyCheckEmailImage),
              ),
              const SizedBox(
                height: ESizes.spaceBtwSeccions,
              ),

              // title and subtitle
              Text(
                ETexts.confirmEmail,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: ESizes.spaceBtwItems,
              ),
              Text(
                email ?? '',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: ESizes.spaceBtwItems,
              ),
              Text(
                ETexts.confirmEmailSubTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: ESizes.spaceBtwSeccions,
              ),

              // button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.checkEmailVerificationStatus(),
                  child: const Text(ETexts.eContinue),
                ),
              ),
              const SizedBox(
                height: ESizes.spaceBtwItems,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => controller.sendEmailVerification(),
                  child: const Text(ETexts.resendEmail),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
