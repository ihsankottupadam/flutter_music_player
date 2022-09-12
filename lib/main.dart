import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:music_player/app/data/models/playlist.dart';
import 'package:music_player/app/modules/home/bindings/initial_bindings.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PlaylistAdapter());
  await Hive.openBox('Favorites');
  await Hive.openBox<Playlist>('Playlist');
  runApp(
    GetMaterialApp(
      title: "Music Player",
      theme: ThemeData(brightness: Brightness.dark),
      initialBinding: InitialBindins(),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
