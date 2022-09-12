import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:music_player/app/modules/library/controllers/library_controller.dart';
import 'package:music_player/app/modules/library/views/tabs.dart' show SongsTab;
import 'package:music_player/app/widgets/bg_container.dart';
import 'package:music_player/app/widgets/mypopupmenu.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../player_screen/controllers/player_controller.dart';

class AlbumScreenView extends StatelessWidget {
  const AlbumScreenView(this.from, this.id, this.title, {Key? key})
      : super(key: key);
  final String title;
  final AudiosFromType from;

  final Object id;
  @override
  Widget build(BuildContext context) {
    return BgContainer(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(title),
            backgroundColor: Colors.transparent,
            actions: [_buildMenu()],
          ),
          body: SongsTab(
              query: Get.find<LibraryController>()
                  .audioQuery
                  .queryAudiosFrom(from, id))),
    );
  }

  _buildMenu() {
    return MyPopupMenu(
        items: [
          MyPopupItem(id: 0, title: 'Play', icon: Icons.play_arrow_rounded),
          MyPopupItem(
              id: 1, title: 'Add to Queue', icon: Icons.queue_music_rounded),
        ],
        onItemSelected: (itemId) async {
          switch (itemId) {
            case 0:
              final songs = await Get.find<LibraryController>()
                  .audioQuery
                  .queryAudiosFrom(from, id);
              Get.find<PlayerController>().playSongs(songs);
              break;

            case 1:
              final songs = await Get.find<LibraryController>()
                  .audioQuery
                  .queryAudiosFrom(from, id);
              Get.find<PlayerController>().addSongsToQueue(songs);
              break;
            default:
          }
        });
  }

  playSongs() async {}
}
