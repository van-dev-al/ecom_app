class EFormatException implements Exception {
  final String? details;

  const EFormatException([this.details]);

  String get message {
    if (details != null && details!.isNotEmpty) {
      return details!;
    } else {
      return 'Invalid data format.';
    }
  }
}
