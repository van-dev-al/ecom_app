import 'package:ecom_app/features/ecom/models/trademark_model.dart';
import 'package:ecom_app/utils/exceptions/firebase_exception.dart';
import 'package:ecom_app/utils/exceptions/format_exception.dart';
import 'package:ecom_app/utils/exceptions/platform_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TrademarkRepository extends GetxController {
  static TrademarkRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<TrademarkModel>> getAllTrademarks() async {
    try {
      final snapshot = await _db.collection('TradeMark').get();
      final result =
          snapshot.docs.map((e) => TrademarkModel.fromSnapshot(e)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const EFormatException();
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } catch (e) {
      throw 'Opp! Something went wrong.';
    }
  }

  Future<List<TrademarkModel>> getTrademarksForCategory(
      String categoryId) async {
    try {
      QuerySnapshot categoryQuery = await _db
          .collection('Categories')
          .where('CategoryId', isEqualTo: categoryId)
          .get();

      if (categoryQuery.docs.isEmpty) {
        throw Exception('Category with id $categoryId not found.');
      }

      DocumentSnapshot categoryDoc = categoryQuery.docs.first;

      Map<String, dynamic> categoryData =
          categoryDoc.data() as Map<String, dynamic>;
      Map<String, dynamic> trademarkCounts = categoryData['TrademarkCounts'];

      List<TrademarkModel> trademarks = [];

      for (var source in trademarkCounts.keys) {
        DocumentSnapshot trademarkDoc =
            await _db.collection('TradeMark').doc(getSourceDocId(source)).get();

        if (!trademarkDoc.exists) {
          continue;
        }

        Map<String, dynamic> trademarkData =
            trademarkDoc.data() as Map<String, dynamic>;
        String image = trademarkData['Image'] ?? '';
        TrademarkModel trademarkModel = TrademarkModel(
          categoryId: categoryId,
          source: source,
          productCount: trademarkCounts[source],
          image: image,
        );
        trademarks.add(trademarkModel);
      }

      return trademarks;
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const EFormatException();
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } catch (e) {
      throw 'Opp! Something went wrong: $e';
    }
  }

  String getSourceDocId(String source) {
    switch (source) {
      case 'tiki.vn':
        return '1';
      case 'cellphones.com.vn':
        return '2';
      case 'didongviet.vn':
        return '3';
      default:
        throw Exception('Unknown source: $source');
    }
  }
}
