import 'dart:async';

import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rxdart/rxdart.dart' as rx_dart;
import 'package:carousel_slider/carousel_controller.dart';
import 'package:we_slide/we_slide.dart';

import '../../../../core/utils/utils.dart';
import '../../../controllers/ui_controller.dart';
import '../../../data/models/position_data.dart';
import 'lyrics_controller.dart';
import 'timer_controller.dart';

class PlayerController extends GetxController {
  final AudioPlayer player = AudioPlayer();
  late List<SongModel> allSongs;
  final timerController = Get.find<TimerController>();
  List<SongModel> songQueue = [];
  late ConcatenatingAudioSource playlist;
  int _currentIndex = -1;
  Rx<SongModel> currentSong = SongModel({'_id': 0}).obs;
  RxInt currentSongId = 0.obs;
  RxBool showMiniPlayer = false.obs;
  final carouselController = CarouselController();
  final flipCardController = FlipCardController();
  final lyricsController = Get.put(LyricsController());
  bool isLoaded = false;
  int get currentIndex => _currentIndex;
  bool get hasPlaylist => songQueue.isNotEmpty;
  final int defSkip = 10000;
  final RxBool volDragging = false.obs;

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
        if (!isLoaded) {
          isLoaded = true;
          return;
        }
        carouselController.animateToPage(event.currentIndex);
      }
    });
  }

  playSongs(List<SongModel> songs, {initialIndex = 0, showPanel = true}) {
    songQueue = [...songs]; //to make hard copy
    if (showMiniPlayer.value == false) {
      showMiniPlayer.value = true;
    }
    _currentIndex = initialIndex;
    playlist = createPlaylist(songs);
    player.setAudioSource(playlist, initialIndex: initialIndex);
    player.androidAudioSessionId;
    player.play();
    update();
    if (showPanel) Get.find<WeSlideController>().show();
  }

  void skipForward() {
    var skipDuration = player.position.inMilliseconds + defSkip;
    int duartion = player.duration?.inMilliseconds ?? 0;
    if (skipDuration < duartion) {
      player.seek(Duration(milliseconds: skipDuration));
    }
  }

  void skipBackward() {
    var skipDuration = player.position.inMilliseconds - defSkip;
    if (skipDuration < 0) skipDuration = 0;
    player.seek(Duration(milliseconds: skipDuration));
  }

  //functions for updating songQueue

  ///for adding list of songs to queue
  ConcatenatingAudioSource createPlaylist(List<SongModel> songs) {
    List<AudioSource> audioSorce = [];

    for (SongModel song in songs) {
      audioSorce.add(AudioSource.uri(
        Uri.parse(song.uri!),
        tag: MediaItem(
          id: '${song.id}',
          album: '${song.album}',
          title: song.title,
          artUri: Uri.parse(
              'content://media/external/audio/media/${song.id}/albumart'),
        ),
      ));
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
    update();
    Fluttertoast.showToast(msg: 'Song added to queue');
  }

  addSongsToQueue(List<SongModel> songs) {
    songQueue.addAll(songs);
    playlist.add(createPlaylist(songs));
    update();
    Fluttertoast.showToast(msg: '${songs.length} songs added to queue');
  }

  addNextInQueue(SongModel song) {
    songQueue.insert(currentIndex + 1, song);
    playlist.insert(currentIndex + 1, createPlaylist([song]));
    update();
    Fluttertoast.showToast(msg: 'Song added to queue');
  }

  // @override
  // void onClose() {
  //   player.dispose();
  //   super.onClose();
  // }

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
      Timer(const Duration(milliseconds: 100),
          () => uiController.setbgColor(color.withOpacity(0.8)));
    } else {
      uiController.setToDefaultColor();
    }
  }

//Lyrics
  toggleLyricsView() {
    if (lyricsController.songId != currentSongId.value) {
      lyricsController.getLyrics(
          currentSongId.value, songQueue[currentIndex].title);
    }
    flipCardController.toggleCard();
  }
}
