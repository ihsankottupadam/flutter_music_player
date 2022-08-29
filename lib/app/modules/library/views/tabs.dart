import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/app/core/values/colors.dart';
import 'package:music_player/app/modules/library/controllers/library_controller.dart';
import 'package:music_player/app/modules/player_screen/controllers/player_controller.dart';
import 'package:music_player/app/widgets/album_tile.dart';
import 'package:music_player/app/widgets/artist_tile.dart';
import 'package:music_player/app/widgets/empty_view.dart';
import 'package:music_player/app/widgets/genres_tile.dart';
import 'package:music_player/app/widgets/song_tile.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:we_slide/we_slide.dart';

class SongsTab extends GetWidget<LibraryController> {
  const SongsTab({Key? key, required this.query}) : super(key: key);
  final Future<List<SongModel>> query;
  @override
  Widget build(BuildContext context) {
    //print('SongsTabRebuilded');
    return GetBuilder<LibraryController>(builder: (context) {
      // print('GETBuilder called');
      return FutureBuilder<List<SongModel>>(
          future: query,
          builder: (BuildContext context, snapshot) {
            //  print('FutureBuilder called');
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data!.isEmpty) {
              return const EmptyView(
                  'Nothing to', 'Show here', 'Add Something');
            }
            List<SongModel> songs = snapshot.data!;
            if (key == const Key('songTab')) {
              controller.songs = songs;
            }

            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: songs.length,
              itemBuilder: (context, index) {
                final song = songs[index];
                return SongTile(
                    song: song,
                    onTap: () {
                      Get.find<PlayerController>()
                          .setPlaylist(songs, initialIndex: index);
                      Get.find<WeSlideController>().show();
                      // Navigator.push(
                      //     context,
                      //     PageRouteBuilder(
                      //         opaque: false,
                      //         pageBuilder: (_, __, ___) =>
                      //             const PlayerScreenView()));
                    });
              },
            );
          });
    });
  }
}

class RecentTab extends GetWidget<LibraryController> {
  const RecentTab({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SongModel>>(
        future: controller.audioQuery.querySongs(
            sortType: SongSortType.DATE_ADDED,
            orderType: OrderType.DESC_OR_GREATER),
        builder: (BuildContext context, snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.isEmpty) {
            return const EmptyView('Nothing to', 'Show here', 'Add Something');
          }
          List<SongModel> songs = snapshot.data!.sublist(0, 20);

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: songs.length,
            itemBuilder: (context, index) {
              final song = songs[index];
              return SongTile(
                  song: song,
                  onTap: () {
                    PlayerController playerController = Get.find();
                    if (playerController.player.playing) {
                      playerController.player.stop();
                    }
                    playerController.setPlaylist(songs, initialIndex: index);
                    Get.find<WeSlideController>().show();
                    // Navigator.push(
                    //     context,
                    //     PageRouteBuilder(
                    //         opaque: false,
                    //         pageBuilder: (_, __, ___) =>
                    //             const PlayerScreenView()));
                  });
            },
          );
        });
  }
}

class AlbumTab extends StatelessWidget {
  final LibraryController controller = Get.find();
  AlbumTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AlbumModel>>(
      future: controller.audioQuery.queryAlbums(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator(color: MyColors.secondary),
          );
        }
        if (snapshot.data!.isEmpty) {
          return const EmptyView('No Album', 'Found', '');
        }
        List<AlbumModel> albums = snapshot.data!;
        return GridView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
            itemCount: albums.length,
            itemBuilder: (context, index) => AlbumTile(album: albums[index]));
      },
    );
  }
}

class ArtistTab extends StatelessWidget {
  final LibraryController controller = Get.find();
  ArtistTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ArtistModel>>(
      future: controller.audioQuery.queryArtists(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator(color: MyColors.secondary),
          );
        }
        if (snapshot.data!.isEmpty) {
          return const EmptyView('No Album', 'Found', '');
        }
        List<ArtistModel> albums = snapshot.data!;
        return GridView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
            itemCount: albums.length,
            itemBuilder: (context, index) =>
                ArtistTile(artistModel: albums[index]));
      },
    );
  }
}

class GenreTab extends StatelessWidget {
  final LibraryController controller = Get.find();
  GenreTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GenreModel>>(
      future: controller.audioQuery.queryGenres(
          uriType: UriType.EXTERNAL, orderType: OrderType.DESC_OR_GREATER),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator(color: MyColors.secondary),
          );
        }
        if (snapshot.data!.isEmpty) {
          return const EmptyView('No Album', 'Found', '');
        }
        List<GenreModel> genre =
            snapshot.data!.where((element) => element.numOfSongs > 0).toList();
        return GridView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
            itemCount: genre.length,
            itemBuilder: (context, index) => GenreTile(genre: genre[index]));
      },
    );
  }
}
