import 'package:ecom_app/bindings/general_binding.dart';
import 'package:ecom_app/utils/helpers/helper_funtions.dart';
import 'package:ecom_app/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;

    final dark = EHelperFuntions.isDarkMode(context);

    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: EAppTheme.lightTheme,
        darkTheme: EAppTheme.darkTheme,
        initialBinding: GeneralBinding(),
        home: Scaffold(
            backgroundColor: dark ? Colors.black : Colors.white,
            body: Center(
                child: CircularProgressIndicator(
                    color: dark ? Colors.white : Colors.black))));
  }
}
