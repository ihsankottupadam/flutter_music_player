import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/app/data/models/playlist.dart';
import 'package:music_player/app/widgets/mypopupmenu.dart';
import 'package:music_player/app/modules/playlist/controllers/playlist_helper.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/app/widgets/bg_container.dart';
import 'package:music_player/app/widgets/song_tile.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../library/views/widgets/empty_songs.dart';
import '../../player_screen/controllers/player_controller.dart';

class PlaylistItemScreen extends StatelessWidget {
  const PlaylistItemScreen({
    Key? key,
    required this.playlistId,
    required this.playlistNmae,
  }) : super(key: key);

  final String playlistNmae;
  final dynamic playlistId;
  @override
  Widget build(BuildContext context) {
    return BgContainer(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(playlistNmae),
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          body: ValueListenableBuilder(
              valueListenable: PlaylistHelper.box.listenable(),
              builder: (contxt, Box<Playlist> box, _) {
                Playlist playlist = box.get(playlistId)!;
                List<SongModel> songs = playlist.getSongs();
                if (songs.isEmpty) {
                  return const EmptySongs();
                }
                return ListView.builder(
                  itemCount: songs.length,
                  itemBuilder: (context, index) {
                    return SongTile(
                        song: songs[index],
                        onTap: () {
                          Get.find<PlayerController>()
                              .playSongs(songs, initialIndex: index);
                        },
                        menu: MyPopupMenu(
                            items: [
                              MyPopupItem(
                                  id: 0,
                                  title: 'Remove from Playlist',
                                  icon: Icons.delete_rounded)
                            ],
                            onItemSelected: (id) {
                              playlist.deleteSong(songs[index]);
                            }));
                  },
                );
              })),
    );
  }
}
