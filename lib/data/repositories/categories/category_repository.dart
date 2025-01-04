import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/features/ecom/models/category_model.dart';
import 'package:ecom_app/utils/exceptions/firebase_exception.dart';
import 'package:ecom_app/utils/exceptions/platform_exception.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  // variables
  final _db = FirebaseFirestore.instance;

  // get all categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
      final list = snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  // get sub categories
}
