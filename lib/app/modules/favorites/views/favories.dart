import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/app/modules/favorites/controllers/favorites_controller.dart';
import 'package:music_player/app/widgets/emptyview.dart';

import 'package:music_player/app/widgets/mypopupmenu.dart';
import 'package:music_player/app/widgets/empty_view.dart';

import 'package:music_player/app/widgets/song_tile.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:we_slide/we_slide.dart';
import '../../player_screen/controllers/player_controller.dart';
import '../../playlist/controllers/playlist_helper.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: GetBuilder<FavoritesController>(builder: (controller) {
        List<SongModel> favSongs = controller.favSongs;
        PlayerController playerController = Get.find();
        WeSlideController slideController = Get.find();
        if (favSongs.isEmpty) {
          return const EmptyViewN(
            text: 'No Songs',
            bottom: 'Found',
          );
        }
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: favSongs.length,
          itemBuilder: (context, index) {
            final song = favSongs[index];
            return SongTile(
              song: song,
              onTap: () {
                playerController.setPlaylist(favSongs, initialIndex: index);
                slideController.show();
              },
              menu: MyPopupMenu(
                  items: [
                    MyPopupItem(
                        id: 0, title: 'Remove', icon: Icons.delete_rounded),
                    MyPopupItem(
                        id: 1,
                        title: 'Add to Playlist',
                        icon: Icons.playlist_add)
                  ],
                  onItemSelected: (id) {
                    switch (id) {
                      case 0:
                        Get.find<FavoritesController>().removeFav(song.id);
                        break;
                      case 1:
                        PlaylistHelper().showPlayistaddBottomSheet(song);
                        break;
                      default:
                        break;
                    }
                  }),
            );
          },
        );
      }),
    );
  }
}
