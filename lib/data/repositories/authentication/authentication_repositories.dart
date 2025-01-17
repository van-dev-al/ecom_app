import 'package:ecom_app/data/repositories/user/user_repositories.dart';
import 'package:ecom_app/features/auth/screens/login/login.dart';
import 'package:ecom_app/features/auth/screens/onboarding/onboarding.dart';
import 'package:ecom_app/features/auth/screens/signup/verify_email.dart';
import 'package:ecom_app/navigation_menu.dart';
import 'package:ecom_app/utils/exceptions/firebase_auth_exception.dart';
import 'package:ecom_app/utils/exceptions/firebase_exception.dart';
import 'package:ecom_app/utils/exceptions/format_exception.dart';
import 'package:ecom_app/utils/exceptions/platform_exception.dart';
import 'package:ecom_app/utils/local_storage/storage_utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepositories extends GetxController {
  static AuthenticationRepositories get instance => Get.find();

  // variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  // Get auth users data
  User? get authUser => _auth.currentUser;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  void screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        // init user specific storage
        await ELocalStorage.init(user.uid);
        Get.offAll(() => const NavigationMenu());
      } else {
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
      }
    } else {
      // local storage
      deviceStorage.writeIfNull('isFirstTime', true);
      deviceStorage.read('isFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(() => const OnBoardingScreen());
    }
  }

  // google sign in
  Future<UserCredential?> signInWithGoogle() async {
    try {
      //
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;

      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      return await _auth.signInWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
      throw EFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } on FormatException catch (_) {
      throw const EFormatException();
    } catch (e) {
      if (kDebugMode) print('Opp! Something went wrong $e');
      return null;
    }
  }

  // Email authentication login, register and logout
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw EFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } on FormatException catch (_) {
      throw const EFormatException();
    } catch (e) {
      throw 'Somthing went wrong. Please try again';
    }
  }

  // register
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw EFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } on FormatException catch (_) {
      throw const EFormatException();
    } catch (e) {
      throw 'Somthing went wrong. Please try again';
    }
  }

  // Email authentication verify
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw EFirebaseAuthException(e.code).message;
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } on FormatException catch (_) {
      throw const EFormatException();
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } catch (e) {
      throw 'Somthing went wrong. Please try again';
    }
  }

  // forgot password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw EFirebaseAuthException(e.code).message;
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } on FormatException catch (_) {
      throw const EFormatException();
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } catch (e) {
      throw 'Somthing went wrong. Please try again';
    }
  }

  // reauthentication user
  Future<void> reAuthenticateWithEmailAndPassword(
      String email, String password) async {
    try {
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);

      //re authenticate
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw EFirebaseAuthException(e.code).message;
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } on FormatException catch (_) {
      throw const EFormatException();
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } catch (e) {
      throw 'Somthing went wrong. Please try again';
    }
  }

  // delete account
  Future<void> deleteAccount() async {
    try {
      await UserRepositories.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      throw EFirebaseAuthException(e.code).message;
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } on FormatException catch (_) {
      throw const EFormatException();
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } catch (e) {
      throw 'Somthing went wrong. Please try again';
    }
  }

  void logoutLogin() async {
    try {
      await AuthenticationRepositories.instance.logout();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      Get.snackbar(
        "Logout Error",
        "Failed to logout: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

// logout user
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw EFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } on FormatException catch (_) {
      throw const EFormatException();
    } catch (e) {
      throw 'Somthing went wrong. Please try again';
    }
  }
}
