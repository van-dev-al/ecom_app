import 'package:ecom_app/data/services/firebase_storage_service.dart';
import 'package:ecom_app/firebase_options.dart';
import 'package:ecom_app/data/repositories/authentication/authentication_repositories.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app.dart';

Future<void> main() async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  // get local storage
  await GetStorage.init();

  // await splash load
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // init firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((FirebaseApp value) => Get.put(AuthenticationRepositories()));

  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity,
  );

  Get.put(EFirebaseStorageService());
  runApp(const App());
}
