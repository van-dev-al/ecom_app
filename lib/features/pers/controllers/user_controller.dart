import 'package:ecom_app/common/widgets/loaders/loaders.dart';
import 'package:ecom_app/data/repositories/authentication/authentication_repositories.dart';
import 'package:ecom_app/data/repositories/user/user_repositories.dart';
import 'package:ecom_app/data/services/netwotk_manager.dart';
import 'package:ecom_app/features/auth/screens/login/login.dart';
import 'package:ecom_app/features/pers/models/user_model.dart';
import 'package:ecom_app/features/pers/screens/profile/widgets/re_authenticate_user_login_form.dart';
import 'package:ecom_app/utils/constaints/image_string.dart';
import 'package:ecom_app/utils/constaints/sizes.dart';
import 'package:ecom_app/utils/helpers/helper_funtions.dart';
import 'package:ecom_app/utils/popups/full_screen_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  Rx<UserModel> user = UserModel.empty().obs;
  final profileLoading = false.obs;

  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepositories());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  // function fetchUserRecord
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  // save user record from any register provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      if (userCredentials != null) {
        final nameParts =
            UserModel.nameParts(userCredentials.user?.displayName ?? '');
        final username =
            UserModel.generateUsername(userCredentials.user?.displayName ?? '');

        final user = UserModel(
          id: userCredentials.user!.uid,
          firstName: nameParts[0],
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
          username: username,
          email: userCredentials.user!.email ?? '',
          phoneNumber: userCredentials.user!.phoneNumber ?? '',
          profilePicture: userCredentials.user!.photoURL ?? '',
        );

        await userRepository.saveUserRecord(user);
      }
    } catch (e) {
      ELoader.warningSnackBar(
          title: 'Data not save?',
          message:
              'Something went wrong while saving your information. You can re-save your data in your Profi;e');
    }
  }

  // dialog delete accounts
  void deleteAccountWarningPopups() {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.all(ESizes.md),
        title: 'Delete Account',
        middleText: 'Are you sure you want to delete your account?',
        backgroundColor: EHelperFuntions.isDarkMode(Get.context!)
            ? Colors.lightBlue[900]
            : Colors.white,
        confirm: ElevatedButton(
            onPressed: () async => deleteUserAccount(),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: ESizes.lg),
              child: Text('Delete'),
            )),
        cancel: OutlinedButton(
            onPressed: () => Navigator.of(Get.overlayContext!).pop(),
            child: const Text('Cancel')));
  }

  // delete user account
  void deleteUserAccount() async {
    try {
      EFullScreenLoader.openLoadingDialog('Processing ..', EImages.loaderImage);

      final auth = AuthenticationRepositories.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;

      if (provider.isNotEmpty) {
        if (provider == 'Google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          EFullScreenLoader.stoploading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          EFullScreenLoader.stoploading();
          Get.to(() => const ReAuthenticateUserLoginForm());
        }
      }
    } catch (e) {
      EFullScreenLoader.stoploading();

      ELoader.warningSnackBar(
          title: 'Opp! Something went wrong.', message: e.toString());
    }
  }

  // re authentication before deleting
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      EFullScreenLoader.openLoadingDialog('Processing ..', EImages.loaderImage);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        EFullScreenLoader.stoploading();
        return;
      }

      if (!reAuthFormKey.currentState!.validate()) {
        EFullScreenLoader.stoploading();
        return;
      }

      await AuthenticationRepositories.instance
          .reAuthenticateWithEmailAndPassword(
              verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepositories.instance.deleteAccount();

      EFullScreenLoader.stoploading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      EFullScreenLoader.stoploading();

      ELoader.warningSnackBar(
          title: 'Opp! Something is wrong.', message: e.toString());
    }
  }
}
