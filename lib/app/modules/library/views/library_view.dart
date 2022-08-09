import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:music_player/app/modules/player_screen/bindings/player_screen_binding.dart';
import 'package:music_player/app/modules/player_screen/controllers/player_controller.dart';
import 'package:music_player/app/modules/player_screen/views/player_screen_view.dart';
import 'package:music_player/app/widgets/bg_container.dart';
import 'package:music_player/app/widgets/empty_view.dart';
import 'package:music_player/app/widgets/gradient_container.dart';
import 'package:music_player/app/widgets/song_tile.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../controllers/library_controller.dart';

class LibraryView extends GetView<LibraryController> {
  const LibraryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BgContainer(
      child: GradientContainer(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: const Text('Library'),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
            ),
            body: SongsTab(query: OnAudioQuery().querySongs())),
      ),
    );
  }
}

class SongsTab extends GetWidget<LibraryController> {
  const SongsTab({Key? key, required this.query}) : super(key: key);
  final Future query;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LibraryController>(builder: (_) {
      return FutureBuilder<List<SongModel>>(
          future: controller.audioQuery.querySongs(uriType: UriType.EXTERNAL),
          builder: (BuildContext context, snapshot) {
            if (snapshot.data == null) {
              return const CircularProgressIndicator();
            }
            if (snapshot.data!.isEmpty) {
              return const EmptyView(
                  'Nothing to', 'Show here', 'Add Something');
            }
            List<SongModel> songs = snapshot.data!;
            controller.songs = songs;
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: songs.length,
              itemBuilder: (context, index) {
                final song = songs[index];
                return SongTile(
                    song: song,
                    onTap: () {
                      //Get.to(() => PlayerScreenView(song: song));
                      Get.find<PlayerController>()
                          .setPlaylist(songs, initialIndex: index);

                      Navigator.push(
                          context,
                          PageRouteBuilder(
                              opaque: false,
                              pageBuilder: (_, __, ___) =>
                                  PlayerScreenView(song: song)));
                    });
              },
            );
          });
    });
  }
}
