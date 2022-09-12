import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

class LibraryController extends GetxController {
  final _audioQuery = OnAudioQuery();
  List<SongModel> songs = [];
  @override
  void onInit() {
    _requestPermission();
    super.onInit();
  }

  OnAudioQuery get audioQuery => _audioQuery;
  _requestPermission() async {
    if (!kIsWeb) {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
        permissionStatus = await _audioQuery.permissionsStatus();
        update();
      }
    }
  }
}
