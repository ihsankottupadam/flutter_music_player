import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/app/modules/player_screen/controllers/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MiniPlayer extends GetWidget<PlayerController> {
  const MiniPlayer({Key? key, required this.onTap}) : super(key: key);
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    AudioPlayer player = controller.player;
    return GestureDetector(
      onTap: onTap,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
        child: Container(
          decoration: BoxDecoration(
              border:
                  Border.all(width: 0, color: Colors.white.withOpacity(0.2)),
              color: Colors.black.withOpacity(0.7)),
          width: double.infinity,
          height: 60,
          child: Row(
            children: [
              Expanded(
                child: StreamBuilder(
                    stream: controller.player.currentIndexStream,
                    builder: (context, _) {
                      return Row(
                        children: [
                          QueryArtworkWidget(
                            id: controller
                                .songQueue[controller.currentIndex].id,
                            artworkHeight: 60,
                            artworkWidth: 60,
                            type: ArtworkType.AUDIO,
                            artworkFit: BoxFit.cover,
                            artworkBorder: BorderRadius.circular(0),
                            nullArtworkWidget: Container(
                              width: 60,
                              height: 60,
                              decoration: const BoxDecoration(
                                color: Color(0x15ffffff),
                              ),
                              child: const Icon(
                                Icons.music_note,
                                color: Color(0xFF5AB2FA),
                                size: 25,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              controller
                                  .songQueue[controller.currentIndex].title,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      );
                    }),
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
              )
            ],
          ),
        ),
      ),
    );
    // return Container(
    //   color: MyColors.secondary,
    //   height: 200,
    // );
  }

  Widget _playButton(PlayerState? playerState) {
    final processingState = playerState?.processingState;
    final audioPlayer = controller.player;
    if (audioPlayer.playing != true) {
      return IconButton(
        icon: const Icon(Icons.play_arrow),
        iconSize: 35.0,
        onPressed: audioPlayer.play,
        tooltip: 'Play',
      );
    } else if (processingState != ProcessingState.completed) {
      return IconButton(
        icon: const Icon(Icons.pause),
        iconSize: 35.0,
        onPressed: audioPlayer.pause,
        tooltip: 'Pause',
      );
    } else {
      return IconButton(
        icon: const Icon(Icons.replay),
        iconSize: 35.0,
        onPressed: () => audioPlayer.seek(Duration.zero,
            index: audioPlayer.effectiveIndices?.first),
      );
    }
  }

  Widget _previousButton() {
    var audioPlayer = controller.player;
    return IconButton(
      //visualDensity: VisualDensity(horizontal: 0.2, vertical: 0.2),
      padding: EdgeInsets.zero,
      icon: const Icon(Icons.skip_previous),
      onPressed: audioPlayer.hasPrevious ? audioPlayer.seekToPrevious : null,
      tooltip: 'Previos',
    );
  }

  Widget _nextButton() {
    var audioPlayer = controller.player;
    return IconButton(
      padding: EdgeInsets.zero,
      icon: const Icon(Icons.skip_next),
      onPressed: audioPlayer.hasNext ? audioPlayer.seekToNext : null,
      tooltip: 'Next',
    );
  }
}
