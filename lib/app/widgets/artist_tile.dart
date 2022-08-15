import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music_player/app/core/values/colors.dart';
import 'package:music_player/app/widgets/mini_playbutton.dart';

import 'package:on_audio_query/on_audio_query.dart';

import '../modules/album_screen/views/album_screen_view.dart';

class ArtistTile extends StatelessWidget {
  const ArtistTile({Key? key, required this.artistModel}) : super(key: key);
  final ArtistModel artistModel;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
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
                child: GridTileBar(
                  backgroundColor: const Color(0x22000000),
                  title: Text(artistModel.artist),
                  subtitle: Text(
                    '${artistModel.numberOfTracks} Songs',
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
                border: Border.all(color: Colors.white.withOpacity(0.2)),
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
