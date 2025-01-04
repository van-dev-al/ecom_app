import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class EStatusBarTheme {
  EStatusBarTheme._();

  // Cập nhật màu sắc của thanh trạng thái cho chế độ sáng/tối
  static void updateStatusBar(bool isDarkMode) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: isDarkMode ? Colors.transparent : Colors.transparent,
        statusBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,
      ),
    );
  }
}
