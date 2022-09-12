import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_music_visualizer/mini_music_visualizer.dart';
import 'package:music_player/app/modules/favorites/controllers/favorites_controller.dart';
import 'package:music_player/app/widgets/mypopupmenu.dart';
import 'package:music_player/app/modules/player_screen/controllers/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../core/utils/utils.dart';
import '../modules/playlist/controllers/playlist_helper.dart';

class SongTile extends StatelessWidget {
  const SongTile(
      {Key? key,
      required this.song,
      required this.onTap,
      this.menu,
      this.showMenu = true,
      this.isSelected = false})
      : super(key: key);
  final SongModel song;
  final VoidCallback? onTap;
  final double radius = 7;
  final Widget? menu;
  final bool showMenu;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    final PlayerController playerController = Get.find();
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onTap: onTap,
      selected: isSelected,
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
      selectedTileColor: Colors.white.withOpacity(0.1),
      selectedColor: Theme.of(context).colorScheme.secondary,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => playerController.currentSongId.value == song.id
                ? ShaderMask(
                    shaderCallback: (rect) => const LinearGradient(
                            colors: [Color(0xff58f9a2), Color(0xff5af8f9)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)
                        .createShader(rect),
                    child: MiniMusicVisualizer(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 4,
                      height: 15,
                    ),
                  )
                : const SizedBox(),
          ),
          //takes menu as menu given otherwise takes songtile menu
          if (showMenu)
            menu ??
                GetBuilder<FavoritesController>(builder: (favController) {
                  return MyPopupMenu(
                      items: [
                        MyPopupItem(
                            id: 0,
                            title: 'Play',
                            icon: Icons.play_arrow_rounded),
                        MyPopupItem(
                            id: 1,
                            title: 'Play next',
                            icon: Icons.play_arrow_rounded),
                        MyPopupItem(
                            id: 2,
                            title: 'Add to Playlist',
                            icon: Icons.playlist_add),
                        !favController.isInFav(song.id)
                            ? MyPopupItem(
                                id: 3,
                                title: 'Add to Favorites',
                                icon: Icons.favorite)
                            : MyPopupItem(
                                id: 4,
                                title: 'Remove from Fav',
                                icon: Icons.favorite_border),
                        MyPopupItem(
                            id: 5,
                            title: 'Add to Queue',
                            icon: Icons.queue_music_rounded)
                      ],
                      onItemSelected: (id) {
                        switch (id) {
                          case 0:
                            playerController.playSongs([song]);

                            break;
                          case 1:
                            playerController.addNextInQueue(song);
                            break;
                          case 2:
                            PlaylistHelper().showPlayistaddBottomSheet(song);
                            break;
                          case 3:
                            favController.addToFav(song);
                            Utils.showSnackBar(text: 'Song added to favorites');
                            break;
                          case 4:
                            favController.removeFav(song.id);
                            Utils.showSnackBar(
                                text: 'Song removed from favorites');
                            break;
                          case 5:
                            playerController.addSongsToQueue([song]);
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
