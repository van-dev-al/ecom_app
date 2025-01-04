import 'package:cloud_firestore/cloud_firestore.dart';

class TrademarkCategoryModel {
  final String source;
  final String categoryId;

  TrademarkCategoryModel({required this.source, required this.categoryId});

  Map<String, dynamic> toJson() {
    return {
      'source': source,
      'categoryId': categoryId,
    };
  }

  factory TrademarkCategoryModel.fromSnapshot(DocumentSnapshot docSnap) {
    final data = docSnap.data() as Map<String, dynamic>;
    return TrademarkCategoryModel(
      source: data['source'] as String,
      categoryId: data['categoryId'] as String,
    );
  }
}
