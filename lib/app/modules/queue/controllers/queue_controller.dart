import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/app/modules/player_screen/controllers/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class QueueController extends GetxController {
  final PlayerController playerController = Get.find();
  late ConcatenatingAudioSource playlist;
  late List<SongModel> songQueue;
  final ScrollController scrollController = ScrollController();
  @override
  void onInit() {
    playlist = playerController.playlist;
    songQueue = playerController.songQueue;

    super.onInit();
  }

  scrollTo(int index) {
    scrollController.animateTo(0,
        duration: Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  reOrderQueue(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    SongModel item = songQueue.removeAt(oldIndex);
    songQueue.insert(newIndex, item);
    playlist.move(oldIndex, newIndex);
    playerController.update();
  }

  removeFromQueue(int index) {
    songQueue.removeAt(index);
    playlist.removeAt(index);
  }
}
