import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music_player/app/core/values/colors.dart';
import 'package:music_player/app/widgets/mini_playbutton.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../modules/album_screen/views/album_screen_view.dart';

class GenreTile extends StatelessWidget {
  const GenreTile({Key? key, required this.genre}) : super(key: key);
  final GenreModel genre;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (contxt) => AlbumScreenView(
                  AudiosFromType.GENRE_ID, genre.id, genre.genre)));
          // Get.to(() =>
          //     AlbumScreenView(AudiosFromType.GENRE_ID, genre.id, genre.genre));
        },
        child: GridTile(
          footer: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                      borderRadius: BorderRadius.circular(10)),
                  child: GridTileBar(
                    backgroundColor: const Color(0x11000000),
                    title: Text(genre.genre),
                    subtitle: Text(
                      '${genre.numOfSongs} Songs',
                      style: TextStyle(
                          fontSize: 12, color: Colors.white.withOpacity(0.5)),
                    ),
                    trailing: MiniPlayButton(
                      onPress: () {
                        print('Go.......');
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          child: QueryArtworkWidget(
            id: genre.id,
            type: ArtworkType.ALBUM,
            artworkFit: BoxFit.cover,
            artworkBorder: BorderRadius.circular(0),
            nullArtworkWidget: Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.only(top: 45),
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0x22ffffff)),
                borderRadius: BorderRadius.circular(10),
                color: const Color(0x09ffffff),
              ),
              child: const Icon(
                Icons.music_note,
                color: MyColors.secondary,
                size: 50,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
