import 'package:get/get.dart';

class ThemeController extends GetxController {
  var dark = false.obs;

  void updateTheme(bool isDark) {
    dark.value = isDark;
  }
}
