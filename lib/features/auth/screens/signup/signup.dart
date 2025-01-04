import 'package:ecom_app/common/widgets/login_signup/form_divider.dart';
import 'package:ecom_app/common/widgets/login_signup/social_buttons.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:ecom_app/utils/constaints/text_string.dart';
import 'package:flutter/material.dart';

import 'widgets/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ESizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                ETexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: ESizes.spaceBtwSeccions,
              ),

              // Form
              const ESignupForm(),
              const SizedBox(
                height: ESizes.spaceBtwSeccions,
              ),
              // Divider
              const EDividerForm(
                diviverText: ETexts.orSignUpWith,
              ),
              const SizedBox(
                height: ESizes.spaceBtwSeccions,
              ),

              // Social buttons
              const ESocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
