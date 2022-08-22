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

  @override
  void dispose() {
    super.dispose();
  }

  OnAudioQuery get audioQuery => _audioQuery;
  _requestPermission() async {
    if (!kIsWeb) {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
        update();
        print('Update called on Library  Contoller....');
      }
    }
  }
}
