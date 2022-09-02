import 'dart:developer';

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
  int _currentIndex = -1;
  Rx<SongModel> currentSong = SongModel({'_id': 0}).obs;
  RxInt currentSongId = 0.obs;
  int get currentIndex => _currentIndex;
  bool get hasPlaylist => songQueue.isNotEmpty;
  RxBool showMiniPlayer = false.obs;
  @override
  void onInit() {
    super.onInit();
    playlist = ConcatenatingAudioSource(children: []);
    player.currentIndexStream.listen((index) {
      if (index != null) {
        // currentSongId.value = songQueue[index].id;
        _currentIndex = index;
      }
    });
    player.sequenceStateStream.listen((event) {
      if (event != null &&
          songQueue[event.currentIndex].id != currentSongId.value) {
        currentSongId.value = songQueue[event.currentIndex].id;
        currentSong.value = songQueue[event.currentIndex];
        _updateBgColor();
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

  Stream<PositionData> get positionDataStream =>
      rx_dart.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          player.positionStream,
          player.bufferedPositionStream,
          player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));
  _updateBgColor() async {
    UiController uiController = Get.find();
    final image = await OnAudioQuery().queryArtwork(
        songQueue[currentIndex].id, ArtworkType.AUDIO,
        format: ArtworkFormat.JPEG);
    if (image != null) {
      final color =
          await Utils.getColorfromImage(imageProvider: MemoryImage(image));
      uiController.setbgColor(color.withOpacity(0.8));
    } else {
      uiController.setToDefaultColor();
    }
  }
  //functions for updating songQueue

  ///for adding list of songs to queue
  ConcatenatingAudioSource createPlaylist(List<SongModel> songs) {
    List<AudioSource> audioSorce = [];

    for (SongModel song in songs) {
      audioSorce.add(AudioSource.uri(Uri.parse(song.uri!)));
    }
    return ConcatenatingAudioSource(children: audioSorce);
  }

  ///for playing specific song from queue
  playfromQueue(int index) {
    player.seek(Duration.zero, index: index);
  }

  addSongToQueue(SongModel song) {
    songQueue.add(song);
    playlist.add(createPlaylist([song]));
  }

  addSongsToQueue(List<SongModel> songs) {
    songQueue.addAll(songs);
    playlist.add(createPlaylist(songs));
  }

  addNextInQueue(SongModel song) {
    songQueue.insert(currentIndex + 1, song);
    playlist.insert(currentIndex + 1, createPlaylist([song]));
  }

  // @override
  // void onClose() {
  //   player.dispose();
  //   super.onClose();
  // }
}
