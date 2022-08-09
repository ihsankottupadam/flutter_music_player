import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:music_player/app/modules/home/bindings/initial_bindings.dart';

import 'app/routes/app_pages.dart';

void main() {
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
