import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rxdart/rxdart.dart' as rx_dart;

import '../../../controllers/ui_controller.dart';
import '../../../core/utils/utils.dart';
import '../../../data/models/position_data.dart';

class PlayerController extends GetxController {
  final AudioPlayer player = AudioPlayer();
  late List<SongModel> allSongs;
  List<SongModel> songQueue = [];
  late ConcatenatingAudioSource playlist;
  // ignore: prefer_final_fields
  int _currentIndex = 0;
  Rx<SongModel> currentSong = SongModel({'_id': 0}).obs;
  RxInt currentSongId = 0.obs;
  int get currentIndex => _currentIndex;
  RxBool showMiniPlayer = false.obs;
  @override
  void onInit() {
    super.onInit();
    player.currentIndexStream.listen((index) {
      if (index != null) {
        // currentSongId.value = songQueue[index].id;
        _currentIndex = index;
        _updateBgColor();
      }
    });
    player.sequenceStateStream.listen((event) {
      if (event != null &&
          songQueue[event.currentIndex].id != currentSongId.value) {
        currentSongId.value = songQueue[event.currentIndex].id;
        currentSong.value = songQueue[event.currentIndex];
      }
    });
  }

  setPlaylist(List<SongModel> songs, {int initialIndex = 0}) {
    songQueue = songs;
    if (showMiniPlayer.value == false) {
      showMiniPlayer.value = true;
    }
    _currentIndex = initialIndex;
    playlist = createPlaylist(songs);
    player.setAudioSource(
      playlist,
      initialIndex: initialIndex,
    );
    player.androidAudioSessionId;
    player.play();
  }

  // Stream<SongModel> songChangeStream() async* {
  //   player.sequenceStateStream.asyncExpand((event) {
  //     print('stram catched');
  //     if (songQueue[currentIndex].id != _prevSongId) {
  //       _prevSongId = currentSongId.value;
  //       currentSongId.value = songQueue[currentIndex].id;
  //       return Stream.value(songQueue[currentIndex]);
  //     }
  //   });
  // }

  Stream<PositionData> get positionDataStream =>
      rx_dart.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          player.positionStream,
          player.bufferedPositionStream,
          player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  ConcatenatingAudioSource createPlaylist(List<SongModel> songs) {
    List<AudioSource> audioSorce = [];

    for (SongModel song in songs) {
      audioSorce.add(AudioSource.uri(Uri.parse(song.uri!)));
    }
    return ConcatenatingAudioSource(children: audioSorce);
  }

  _updateBgColor() async {
    UiController uiController = Get.find();
    final image = await OnAudioQuery().queryArtwork(
        songQueue[currentIndex].id, ArtworkType.AUDIO,
        format: ArtworkFormat.JPEG);
    if (image != null) {
      final colors =
          await Utils.getColorsfromImage(imageProvider: MemoryImage(image));
      uiController.setbgColor(colors.elementAt(0).withOpacity(0.8));
    } else {
      uiController.setToDefaultColor();
    }
  }

  // @override
  // void onClose() {
  //   player.dispose();
  //   super.onClose();
  // }
}
