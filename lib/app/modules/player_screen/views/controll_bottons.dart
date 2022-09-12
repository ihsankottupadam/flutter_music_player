import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../routes/app_pages.dart';
import '../../playlist/controllers/playlist_helper.dart';
import '../../../data/models/position_data.dart';
import '../../../widgets/favorite_button.dart';
import '../controllers/player_controller.dart';

class ControllButtons extends GetWidget<PlayerController> {
  const ControllButtons({Key? key}) : super(key: key);
  final cColor = const Color(0xff18f7f7);
  @override
  Widget build(BuildContext context) {
    var player = controller.player;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            StreamBuilder<SongModel>(
                stream: controller.currentSong.stream,
                builder: (context, snapshot) {
                  if (!controller.hasPlaylist) {
                    return const SizedBox();
                  }
                  final currSong = controller.currentSong.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: 50,
                          child: Marquee(
                            text: currSong.title,
                            fadingEdgeEndFraction: 0.1,
                            fadingEdgeStartFraction: 0.1,
                            blankSpace: 30,
                            pauseAfterRound: const Duration(seconds: 3),
                            startAfter: const Duration(seconds: 3),
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          )),
                      Text(
                        currSong.album ?? 'unknown',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white.withOpacity(0.7)),
                      )
                    ],
                  );
                }),

            //controlls
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.timer_sharp),
                tooltip: 'Timer',
              ),
              IconButton(
                onPressed: () => Get.toNamed(Routes.QUEUE),
                icon: const Icon(Icons.queue_music),
                tooltip: 'Add to Queue',
              ),
              IconButton(
                onPressed: () => PlaylistHelper()
                    .showPlayistaddBottomSheet(controller.currentSong.value),
                icon: const Icon(Icons.playlist_add),
                tooltip: 'Add to playlist',
              ),
              StreamBuilder(
                  stream: controller.currentSong.stream,
                  builder: (context, snapshot) {
                    if (!controller.hasPlaylist) {
                      return const Icon(Icons.favorite);
                    }
                    return FavoriteButton(
                      song: controller.currentSong.value,
                    );
                  })
            ]),
            //seekbar
            StreamBuilder<PositionData>(
              stream: controller.positionDataStream,
              builder: (context, snapshot) {
                PositionData? positionData = snapshot.data;
                return ProgressBar(
                  progress: positionData?.position ?? Duration.zero,
                  buffered: positionData?.bufferedPosition,
                  total: positionData?.duration ?? Duration.zero,
                  progressBarColor: cColor,
                  thumbColor: Colors.white,
                  baseBarColor: const Color(0x33ffffff),
                  bufferedBarColor: Colors.transparent,
                  barHeight: 4,
                  thumbRadius: 6,
                  thumbGlowRadius: 15,
                  onSeek: (duration) {
                    player.seek(duration);
                  },
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StreamBuilder<bool>(
                  stream: player.shuffleModeEnabledStream,
                  builder: (context, snapshot) =>
                      _shuffleButton(context, snapshot.data ?? false),
                ),
                StreamBuilder<SequenceState?>(
                  stream: player.sequenceStateStream,
                  builder: (_, __) {
                    return _previousButton();
                  },
                ),
                StreamBuilder<PlayerState>(
                  stream: player.playerStateStream,
                  builder: (_, snapshot) {
                    final playerState = snapshot.data;
                    return _playButton(playerState);
                  },
                ),
                StreamBuilder<SequenceState?>(
                  stream: player.sequenceStateStream,
                  builder: (_, __) {
                    return _nextButton();
                  },
                ),
                StreamBuilder<LoopMode>(
                    stream: player.loopModeStream,
                    builder: (context, snapshot) =>
                        _repeatButton(context, snapshot.data ?? LoopMode.off))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _shuffleButton(BuildContext context, bool isEnabled) {
    return IconButton(
      icon: isEnabled
          ? Icon(Icons.shuffle, color: cColor)
          : const Icon(Icons.shuffle),
      onPressed: () async {
        final enable = !isEnabled;
        if (enable) {
          await controller.player.shuffle();
        }
        await controller.player.setShuffleModeEnabled(enable);
      },
      tooltip: 'Shuffle',
    );
  }

  Widget _repeatButton(BuildContext context, LoopMode loopMode) {
    final icons = [
      const Icon(Icons.repeat),
      Icon(Icons.repeat, color: cColor),
      Icon(Icons.repeat_one, color: cColor),
    ];
    const cycleModes = [
      LoopMode.off,
      LoopMode.all,
      LoopMode.one,
    ];
    final index = cycleModes.indexOf(loopMode);
    return IconButton(
      icon: icons[index],
      onPressed: () {
        controller.player.setLoopMode(
            cycleModes[(cycleModes.indexOf(loopMode) + 1) % cycleModes.length]);
      },
      tooltip: 'Repeat',
    );
  }

  Widget _playButton(PlayerState? playerState) {
    final processingState = playerState?.processingState;
    final audioPlayer = controller.player;
    if (audioPlayer.playing != true) {
      return IconButton(
        icon: const Icon(Icons.play_arrow),
        iconSize: 64.0,
        onPressed: audioPlayer.play,
        tooltip: 'Play',
      );
    } else if (processingState != ProcessingState.completed) {
      return IconButton(
        icon: const Icon(Icons.pause),
        iconSize: 64.0,
        onPressed: audioPlayer.pause,
        tooltip: 'Pause',
      );
    } else {
      return IconButton(
        icon: const Icon(Icons.replay),
        iconSize: 64.0,
        onPressed: () => audioPlayer.seek(Duration.zero,
            index: audioPlayer.effectiveIndices?.first),
      );
    }
  }

  Widget _previousButton() {
    var audioPlayer = controller.player;
    return IconButton(
      icon: const Icon(Icons.skip_previous),
      onPressed: audioPlayer.hasPrevious ? audioPlayer.seekToPrevious : null,
      tooltip: 'Previos',
    );
  }

  Widget _nextButton() {
    var audioPlayer = controller.player;
    return IconButton(
      icon: const Icon(Icons.skip_next),
      onPressed: audioPlayer.hasNext ? audioPlayer.seekToNext : null,
      tooltip: 'Next',
    );
  }
}
