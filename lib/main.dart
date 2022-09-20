import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_player/app/data/models/playlist.dart';
import 'package:music_player/app/modules/home/bindings/initial_bindings.dart';
import 'package:music_player/core/theme/app_theme.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PlaylistAdapter());
  await Hive.openBox('Favorites');
  await Hive.openBox<Playlist>('Playlist');
  await JustAudioBackground.init(
    androidNotificationIcon: 'drawable/ic_notification',
    notificationColor: const Color(0xFFE6E6E6),
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  runApp(
    GetMaterialApp(
      title: "Music Player",
      theme: AppTheme.theme,
      initialBinding: InitialBindins(),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
