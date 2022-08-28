import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_music_visualizer/mini_music_visualizer.dart';
import 'package:music_player/app/modules/favorites/controllers/favorites_controller.dart';
import 'package:music_player/app/widgets/mypopupmenu.dart';
import 'package:music_player/app/modules/player_screen/controllers/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../modules/playlist/controllers/playlist_helper.dart';

class SongTile extends StatelessWidget {
  const SongTile({Key? key, required this.song, required this.onTap, this.menu})
      : super(key: key);
  final SongModel song;
  final VoidCallback onTap;
  final double radius = 7;
  final Widget? menu;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onTap: onTap,
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
            //color: const Color(0x15ffffff),
            gradient: const LinearGradient(
              colors: [Color(0x33ffffff), Color(0x33000000)],
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
            ),
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
                ? const MiniMusicVisualizer(
                    color: Colors.blue,
                    width: 4,
                    height: 15,
                  )
                : const SizedBox(),
          ),
          //takes menu as menu given otherwise takes songtile menu
          menu ??
              GetBuilder<FavoritesController>(builder: (favController) {
                return MyPopupMenu(
                    items: [
                      MyPopupItem(
                          id: 0,
                          title: 'Add to Playlist',
                          icon: Icons.playlist_add),
                      !favController.isInFav(song.id)
                          ? MyPopupItem(
                              id: 1,
                              title: 'Add to Favorites',
                              icon: Icons.favorite)
                          : MyPopupItem(
                              id: 2,
                              title: 'Remove from Fav',
                              icon: Icons.favorite_border),
                    ],
                    onItemSelected: (id) {
                      switch (id) {
                        case 0:
                          PlaylistHelper().showPlayistaddBottomSheet(song);
                          break;
                        case 1:
                          favController.addToFav(song);
                          break;
                        case 2:
                          favController.removeFav(song.id);
                          break;
                        default:
                          break;
                      }
                    });
              })
        ],
      ),
    );
  }
}
