import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../core/values/colors.dart';
import '../modules/album_screen/views/album_screen_view.dart';
import '../modules/library/controllers/library_controller.dart';
import '../modules/player_screen/controllers/player_controller.dart';
import 'mini_playbutton.dart';

class ArtistTile extends StatelessWidget {
  const ArtistTile({Key? key, required this.artistModel}) : super(key: key);
  final ArtistModel artistModel;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (contxt) => AlbumScreenView(AudiosFromType.ARTIST_ID,
                  artistModel.id, artistModel.artist)));
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
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.2),
                        const Color(0x00ffffff)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: GridTileBar(
                    backgroundColor: const Color(0x22000000),
                    title: Text(artistModel.artist),
                    subtitle: Text(
                      '${artistModel.numberOfTracks} Songs',
                      style: TextStyle(
                          fontSize: 12, color: Colors.white.withOpacity(0.5)),
                    ),
                    trailing: MiniPlayButton(
                      onPress: () async {
                        final songs = await Get.find<LibraryController>()
                            .audioQuery
                            .queryAudiosFrom(
                                AudiosFromType.ARTIST_ID, artistModel.id);
                        Get.find<PlayerController>().playSongs(songs);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          child: QueryArtworkWidget(
            id: artistModel.id,
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
                color: const Color(0x22000000),
              ),
              child: const Icon(
                Icons.person,
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
