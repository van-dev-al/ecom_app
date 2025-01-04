import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String categoryId;
  String name;
  String image;
  String parentId;
  bool isFeatured;

  CategoryModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.image,
    required this.isFeatured,
    this.parentId = '',
  });

  // empty helper function
  static CategoryModel empty() => CategoryModel(
        id: '',
        image: '',
        name: '',
        isFeatured: false,
        categoryId: '',
      );

  // convert model to json structure so that u can store data in firestore
  Map<String, dynamic> toJson() {
    return {
      'CategoryId': categoryId,
      'Name': name,
      'Image': image,
      'ParentId': parentId,
      'IsFeatured': isFeatured,
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return CategoryModel.empty();
    return CategoryModel(
      id: data['Id'] ?? '',
      name: data['Name'] ?? '',
      image: data['Image'] ?? '',
      parentId: data['ParentId'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      isFeatured: data['IsFeatured'] ?? false,
    );
  }

  // map json oriented doc snapshot from firestore to usermodel
  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      return CategoryModel(
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        parentId: data['ParentId'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
        categoryId: data['CategoryId'] ?? '',
      );
    } else {
      return CategoryModel.empty();
    }
  }
}
