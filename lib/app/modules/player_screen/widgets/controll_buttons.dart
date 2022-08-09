import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlayButton extends StatelessWidget {
  const PlayButton(
      {Key? key, required, this.isMiniplayer = false, required this.player})
      : super(key: key);
  final AudioPlayer player;
  final bool isMiniplayer;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
        stream: player.playerStateStream,
        builder: (context, snapshot) {
          final playerState = snapshot.data;
          final processingState = playerState?.processingState;
          final playing = playerState?.playing ?? true;
          final double size = isMiniplayer ? 40 : 65;
          return SizedBox(
            width: size,
            height: size,
            child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.center,
                children: [
                  if (processingState == ProcessingState.loading ||
                      processingState == ProcessingState.buffering)
                    const CircularProgressIndicator(
                      color: Color(0xffffffff),
                      strokeWidth: 1,
                    ),
                  playing
                      ? IconButton(
                          onPressed: () {
                            player.pause();
                          },
                          icon: Icon(
                            size: size,
                            Icons.pause_rounded,
                          ))
                      : IconButton(
                          onPressed: () {
                            player.play;
                          },
                          icon: Icon(
                            size: size,
                            Icons.play_arrow_rounded,
                            semanticLabel: 'Play;',
                          ))
                ]),
          );
        });
  }
}
