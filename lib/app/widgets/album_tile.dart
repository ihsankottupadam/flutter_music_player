import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music_player/app/core/values/colors.dart';
import 'package:music_player/app/modules/album_screen/views/album_screen_view.dart';
import 'package:music_player/app/widgets/mini_playbutton.dart';

import 'package:on_audio_query/on_audio_query.dart';

class AlbumTile extends StatelessWidget {
  const AlbumTile({Key? key, required this.album}) : super(key: key);
  final AlbumModel album;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: () {
          // Get.to(() =>
          //     AlbumScreenView(AudiosFromType.ALBUM_ID, album.id, album.album));
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AlbumScreenView(
                  AudiosFromType.ALBUM_ID, album.id, album.album)));
        },
        child: GridTile(
          footer: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: GridTileBar(
                  backgroundColor: const Color(0x25000000),
                  title: Text(album.album),
                  subtitle: Text(
                    '${album.numOfSongs} Songs',
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
          child: QueryArtworkWidget(
            id: album.id,
            type: ArtworkType.ALBUM,
            artworkFit: BoxFit.cover,
            artworkBorder: BorderRadius.circular(0),
            nullArtworkWidget: Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.only(top: 45),
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0x15ffffff),
              ),
              child: const Icon(
                Icons.album,
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
