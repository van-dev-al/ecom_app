import 'package:ecom_app/common/widgets/loaders/loaders.dart';
import 'package:ecom_app/data/repositories/authentication/authentication_repositories.dart';
import 'package:ecom_app/data/services/netwotk_manager.dart';
import 'package:ecom_app/features/pers/controllers/user_controller.dart';
import 'package:ecom_app/utils/constaints/image_string.dart';
import 'package:ecom_app/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  //variable
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  final localStorage = GetStorage();
  final hidePassword = true.obs;
  final rememberMe = false.obs;

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  Future<void> emailAndPasswordSignin() async {
    try {
      // start loading
      EFullScreenLoader.openLoadingDialog(
          'Logging you in ...', EImages.facebook);

      // check internet
      final iConnected = await NetworkManager.instance.isConnected();
      if (!iConnected) {
        EFullScreenLoader.stoploading();
        return;
      }

      // login form validate
      if (!loginFormKey.currentState!.validate()) {
        EFullScreenLoader.stoploading();
        return;
      }

      // save data if remember me is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      } else {
        localStorage.remove('REMEMBER_ME_EMAIL');
        localStorage.remove('REMEMBER_ME_PASSWORD');
      }

      // login process
      // ignore: unused_local_variable
      final userCredential = await AuthenticationRepositories.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // remove loader
      EFullScreenLoader.stoploading();

      // redirect
      AuthenticationRepositories.instance.screenRedirect();
    } catch (e) {
      EFullScreenLoader.stoploading();

      ELoader.errorSnackBar(
          title: 'Opp! Somthing went wrong Login', message: e.toString());
    }
  }

  // google sign in
  Future<void> googleSignIn() async {
    try {
      // loader
      EFullScreenLoader.openLoadingDialog(
          'Logging you in ..', EImages.loaderImage);

      // check network
      final iConnected = await NetworkManager.instance.isConnected();
      if (!iConnected) {
        EFullScreenLoader.stoploading();
        return;
      }

      final userCredentials =
          await AuthenticationRepositories.instance.signInWithGoogle();

      await userController.saveUserRecord(userCredentials);

      EFullScreenLoader.stoploading();

      AuthenticationRepositories.instance.screenRedirect();
    } catch (e) {
      //
      EFullScreenLoader.stoploading();
      ELoader.errorSnackBar(
          title: 'Opp! Something went wrong.', message: e.toString());
    }
  }
}
