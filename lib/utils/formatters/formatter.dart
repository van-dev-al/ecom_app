import 'package:intl/intl.dart';

class EFormatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MM-yyyy').format(date);
  }

  static String formatTime(DateTime? time) {
    time ??= DateTime.now();
    return DateFormat('HH:mm:ss').format(time);
  }

  static String formatDateTime(DateTime? dateTime) {
    dateTime ??= DateTime.now();
    return DateFormat('dd-MM-yyyy HH:mm:ss').format(dateTime);
  }

  static String formatCurrency(double? amount) {
    if (amount == null) return "₫0";
    return NumberFormat.currency(locale: 'vi_VN', symbol: '₫', decimalDigits: 0)
        .format(amount);
  }

  static String formatLargeNumber(double value) {
    if (value >= 1e9) {
      return "${(value / 1e9).toStringAsFixed(1)}B"; // B: Billion
    } else if (value >= 1e6) {
      return "${(value / 1e6).toStringAsFixed(1)}M"; // M: Million
    } else if (value >= 1e3) {
      return "${(value / 1e3).toStringAsFixed(1)}k"; // k: Thousand
    }
    return value.toStringAsFixed(1); // Trả về số gốc nếu nhỏ hơn 1,000
  }

  // To Upercase first letter of the string
  static String capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1).toLowerCase();
  }

  static String capitalizeFirst(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1);
  }

  static String formatPhoneNumber(String phoneNumber) {
    // Phone number VN format: +84 1 2345-6789 with 10-digit and +84 12 3456-7890 with 11-digit
    if (phoneNumber.length == 10 && phoneNumber.startsWith('0')) {
      return "+84 ${phoneNumber.substring(1, 2)} ${phoneNumber.substring(2, 6)}-${phoneNumber.substring(6)}";
    } else if (phoneNumber.length == 11 && phoneNumber.startsWith('0')) {
      return "+84 ${phoneNumber.substring(1, 3)} ${phoneNumber.substring(3, 7)}-${phoneNumber.substring(7)}";
    }
    return phoneNumber;
  }
}
