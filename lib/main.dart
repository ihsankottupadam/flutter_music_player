import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:music_player/app/modules/home/bindings/initial_bindings.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('Favorites');
  runApp(
    GetMaterialApp(
      title: "Application",
      theme: ThemeData(brightness: Brightness.dark),
      initialBinding: InitialBindins(),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
