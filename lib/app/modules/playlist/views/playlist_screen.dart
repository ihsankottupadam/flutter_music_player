import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/app/data/models/playlist.dart';
import 'package:music_player/app/modules/playlist/views/item_screen.dart';
import 'package:music_player/app/modules/playlist/widgets/playlist_tile.dart';

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              leading: const Icon(Icons.add),
              title: const Text(
                'Create Playlist',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                playlistHelper.createPlaylist(context);
              },
            ),
            ValueListenableBuilder(
                valueListenable: PlaylistHelper.box.listenable(),
                builder: (context, Box<Playlist> box, _) {
                  List<Playlist> playlists = box.values.toList();
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
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
                })
          ],
        ),
      ),
    );
  }
}
