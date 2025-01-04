import 'package:cloud_firestore/cloud_firestore.dart';

class TrademarkModel {
  String? id;
  String source;
  String image;
  String? categoryId;
  bool? isFeatured;
  int? productCount;

  TrademarkModel({
    this.id,
    required this.source,
    this.categoryId,
    required this.image,
    this.isFeatured,
    this.productCount,
  });

  // empty function
  static TrademarkModel empty() =>
      TrademarkModel(id: '', source: '', image: '');

  toJson() {
    return {
      'Id': id,
      'Source': source,
      'Image': image,
      'IsFeatured': isFeatured,
      'ProductCount': productCount,
    };
  }

  // map json oriented doc snapshot from firestore to usermodel
  factory TrademarkModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return TrademarkModel.empty();
    return TrademarkModel(
      id: data['id'] ?? '',
      source: data['Source'] ?? '',
      image: data['Image'] ?? '',
      isFeatured: data['IsFeatured'] ?? false,
      productCount: int.parse((data['ProductCount'] ?? 0).toString()),
    );
  }

  factory TrademarkModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      return TrademarkModel(
        id: document.id,
        source: data['Source'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
        productCount: int.parse((data['ProductCount'] ?? 0).toString()),
        image: data['Image'] ?? [],
      );
    } else {
      return TrademarkModel.empty();
    }
  }
}
