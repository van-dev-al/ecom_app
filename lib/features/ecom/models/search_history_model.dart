import 'package:cloud_firestore/cloud_firestore.dart';

class SearchHistoryModel {
  final String query;
  final DateTime timestamp;

  SearchHistoryModel({
    required this.query,
    required this.timestamp,
  });

  factory SearchHistoryModel.fromSnapshot(Map<String, dynamic> data) {
    return SearchHistoryModel(
      query: data['query'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }
}
