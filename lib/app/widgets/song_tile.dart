import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_music_visualizer/mini_music_visualizer.dart';
import 'package:music_player/app/modules/player_screen/controllers/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongTile extends StatelessWidget {
  const SongTile({Key? key, required this.song, required this.onTap})
      : super(key: key);
  final SongModel song;
  final VoidCallback onTap;
  final double radius = 7;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      //splashColor: Color(0x552196F3),
      borderRadius: BorderRadius.circular(10),
      child: ListTile(
        title: Text(
          song.title,
          maxLines: 1,
          style: const TextStyle(
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: Text(
          '${song.artist ?? '<unknown>'}  - ${song.album ?? '<Unknown>'}'
              .replaceAll('<unknown>', 'unknown'),
          maxLines: 1,
          style: const TextStyle(
            overflow: TextOverflow.ellipsis,
          ),
        ),
        leading: QueryArtworkWidget(
          id: song.id,
          type: ArtworkType.AUDIO,
          artworkFit: BoxFit.cover,
          artworkBorder: BorderRadius.circular(radius),
          nullArtworkWidget: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: const Color(0x15ffffff),
            ),
            child: const Icon(
              Icons.music_note,
              color: Color(0xFF5AB2FA),
            ),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => Get.find<PlayerController>().currentSongId.value == song.id
                  ? MiniMusicVisualizer(
                      color: Colors.blue,
                      width: 4,
                      height: 15,
                    )
                  : SizedBox(),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),
      ),
    );
  }
}
