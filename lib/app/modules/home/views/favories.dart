import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/app/controllers/favorites_controller.dart';
import 'package:music_player/app/widgets/empty_view.dart';
import 'package:music_player/app/widgets/favorite_tile.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:we_slide/we_slide.dart';
import '../../player_screen/controllers/player_controller.dart';

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
            return const EmptyView('Nothing', 'to show', 'go and add somthing');
          }
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: favSongs.length,
            itemBuilder: (context, index) => FavoriteTile(
                song: favSongs[index],
                onTap: () {
                  playerController.setPlaylist(favSongs, initialIndex: index);
                  slideController.show();
                }),
          );
        }));
  }
}
