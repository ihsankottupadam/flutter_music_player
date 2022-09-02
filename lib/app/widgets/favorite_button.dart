import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/app/modules/favorites/controllers/favorites_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    Key? key,
    required this.song,
  }) : super(key: key);
  final SongModel song;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoritesController>(
      builder: (controller) {
        bool isFav = controller.isInFav(song.id);
        return IconButton(
            onPressed: () {
              if (isFav) {
                controller.removeFav(song.id);
              } else {
                controller.addToFav(song);
              }
            },
            icon: Icon(
              Icons.favorite,
              color: isFav ? Colors.red : Colors.grey,
            ),
            tooltip: 'Favorite');
      },
    );
  }
}
