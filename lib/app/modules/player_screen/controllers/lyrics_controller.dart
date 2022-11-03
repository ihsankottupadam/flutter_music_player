import 'package:get/get.dart';

import '../../../data/services/lyrics_service.dart';

class LyricsController extends GetxController {
  int songId = -1;
  String? lyrics;
  void getLyrics(int songId, String title) async {
    this.songId = songId;
    lyrics = null;
    update();
    LyricsService()
        .searchLyrics(title)
        .then((value) => lyrics = value ?? 'empty')
        .onError((error, _) {
      if (error.toString() == 'No Connection') lyrics = error.toString();
      return '';
    }).whenComplete(() => update());
    update();
    return null;
  }
}
