import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/app/data/models/playlist.dart';
import 'package:music_player/app/modules/playlist/views/item_screen.dart';
import 'package:music_player/app/modules/playlist/widgets/playlist_tile.dart';
import 'package:music_player/app/widgets/empty_view.dart';

import '../controllers/playlist_helper.dart';

class PlaylistScreen extends StatelessWidget {
  PlaylistScreen({Key? key}) : super(key: key);
  final PlaylistHelper playlistHelper = PlaylistHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Playlists'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            leading: const Icon(Icons.add),
            title: const Text(
              'Create Playlist',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            onTap: () {
              playlistHelper.createPlaylist(context);
            },
          ),
          Expanded(
            child: ValueListenableBuilder(
                valueListenable: PlaylistHelper.box.listenable(),
                builder: (context, Box<Playlist> box, _) {
                  List<Playlist> playlists = box.values.toList();
                  if (playlists.isEmpty) {
                    return const EmptyView(
                      icon: Icons.playlist_play_rounded,
                      text: 'No Playlists',
                    );
                  }
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: playlists.length,
                    itemBuilder: (context, index) {
                      return PlaylistTile(
                        playlist: playlists[index],
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PlaylistItemScreen(
                                      playlistId: playlists[index].id,
                                      playlistNmae: playlists[index].name)));
                        },
                      );
                    },
                  );
                }),
          )
        ],
      ),
    );
  }
}
