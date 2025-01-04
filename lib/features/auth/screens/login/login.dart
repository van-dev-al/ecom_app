import 'package:ecom_app/common/styles/spacing_styles.dart';
import 'package:ecom_app/features/auth/screens/login/widgets/login_form.dart';
import 'package:ecom_app/utils/constaints/text_string.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../common/widgets/login_signup/social_buttons.dart';
import '../../../../utils/constaints/sizes.dart';
import 'widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put(LoginController());

    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: ESpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              // Logo, title and subtitle
              ELoginHeader(),
              // Login form
              ELoginForm(),

              // Divider
              EDividerForm(
                diviverText: ETexts.orSignInWith,
              ),
              SizedBox(
                height: ESizes.spaceBtwSeccions,
              ),

              // Footer
              ESocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
