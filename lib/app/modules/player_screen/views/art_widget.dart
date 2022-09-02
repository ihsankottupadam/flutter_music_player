import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../controllers/player_controller.dart';

class ArtWidget extends GetWidget<PlayerController> {
  const ArtWidget({
    Key? key,
    required this.height,
  }) : super(key: key);
  final double height;
  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: SizedBox(
      height: height * 1.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Align(
              alignment: Alignment.centerRight,
              child: StreamBuilder(
                  stream: controller.player.sequenceStateStream,
                  builder: (context, snapshot) {
                    return Text(
                        '${controller.currentIndex + 1}/${controller.songQueue.length}');
                  }),
            ),
          ),
          StreamBuilder<SongModel>(
              stream: controller.currentSong.stream,
              builder: (_, snapshot) {
                if (snapshot.data == null) {
                  return SizedBox(height: height);
                }
                return QueryArtworkWidget(
                  id: snapshot.data!.id,
                  artworkHeight: height,
                  artworkWidth: height,
                  type: ArtworkType.AUDIO,
                  artworkFit: BoxFit.cover,
                  artworkBorder: BorderRadius.circular(10),
                  nullArtworkWidget: Container(
                    width: height,
                    height: height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0x55ffffff),
                          Color(0x15ffffff),
                          Color(0x33000000)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Icon(
                      Icons.music_note,
                      color: const Color(0xFF5AB2FA),
                      size: height * 0.25,
                    ),
                  ),
                );
              }),
        ],
      ),
    ));
  }
}
