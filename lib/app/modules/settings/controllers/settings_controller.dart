import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/playlist.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/dialog_confirm.dart';
import '../../favorites/controllers/favorites_controller.dart';

class SettingsController extends GetxController {
  void reset(context) {
    showDialog(
        context: context,
        builder: (context) => ConfirmDialog(
              title: 'Warning',
              text:
                  "This will permanently delete the app's data including playlists and favorites",
              conformText: 'Reset',
              onConfirm: () async {
                Navigator.pop(context);
                Hive.box<Playlist>('Playlist').clear();
                await Hive.box('Favorites').clear();
                Get.find<FavoritesController>()
                  ..favSongs.clear()
                  ..update();
                Get.offNamedUntil(Routes.HOME, (route) => false);
              },
            ));
  }

  void feedback() async {
    final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'ihsanpv007@gmail.com',
        query: 'subject=Feedback about Music Player app&body=');

    if (!await launchUrl(emailLaunchUri)) {
      throw '';
    }
  }
}
