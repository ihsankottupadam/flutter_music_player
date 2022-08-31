import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:music_player/app/modules/library/controllers/library_controller.dart';
import 'package:music_player/app/modules/library/views/tabs.dart' show SongsTab;
import 'package:music_player/app/widgets/bg_container.dart';
import 'package:on_audio_query/on_audio_query.dart';

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
          ),
          body: SongsTab(
              query: Get.find<LibraryController>()
                  .audioQuery
                  .queryAudiosFrom(from, id))),
    );
  }
}
