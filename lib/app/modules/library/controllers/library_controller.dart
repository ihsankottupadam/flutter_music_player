import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class LibraryController extends GetxController {
  final _audioQuery = OnAudioQuery();
  List<SongModel> songs = [];
  @override
  void onInit() {
    requestPermission();
    super.onInit();
  }

  OnAudioQuery get audioQuery => _audioQuery;
  requestPermission() async {
    // Web platform don't support permissions methods.
    if (!kIsWeb) {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
      }
      update();
    }
  }
}
