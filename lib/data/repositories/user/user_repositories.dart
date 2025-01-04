import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/data/repositories/authentication/authentication_repositories.dart';
import 'package:ecom_app/utils/exceptions/firebase_auth_exception.dart';
import 'package:ecom_app/utils/exceptions/platform_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../features/pers/models/user_model.dart';
import '../../../utils/exceptions/firebase_exception.dart';
import '../../../utils/exceptions/format_exception.dart';

class UserRepositories extends GetxController {
  static UserRepositories get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // function save user data to Firestore
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
    } on FirebaseAuthException catch (e) {
      throw EFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const EFormatException();
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } catch (e) {
      throw 'Somthing went wrong user reposi. Please try again';
    }
  }

  // funtion fetch user information on user id
  Future<UserModel> fetchUserDetails() async {
    try {
      final document = await _db
          .collection("Users")
          .doc(AuthenticationRepositories.instance.authUser?.uid)
          .get();
      if (document.exists) {
        return UserModel.fromSnapshot(document);
      } else {
        return UserModel.empty();
      }
    } on FormatException catch (_) {
      throw const EFormatException();
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } catch (e) {
      throw 'Somthing went wrong user reposi. Please try again';
    }
  }

  // function update user data to Firestore
  Future<void> updateUserDetails(UserModel updateUser) async {
    try {
      await _db
          .collection("Users")
          .doc(updateUser.id)
          .update(updateUser.toJson());
    } on FormatException catch (_) {
      throw const EFormatException();
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } catch (e) {
      throw 'Somthing went wrong user reposi. Please try again';
    }
  }

  // update any fields detail in user profile
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepositories.instance.authUser?.uid)
          .update(json);
    } on FormatException catch (_) {
      throw const EFormatException();
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } catch (e) {
      throw 'Somthing went wrong user reposi. Please try again';
    }
  }

  // function remove user data to Firestore
  Future<void> removeUserRecord(String userID) async {
    try {
      await _db.collection("Users").doc(userID).delete();
    } on FormatException catch (_) {
      throw const EFormatException();
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } catch (e) {
      throw 'Somthing went wrong user reposi. Please try again';
    }
  }
}
