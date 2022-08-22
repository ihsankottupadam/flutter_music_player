import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:music_player/app/core/values/colors.dart';
import 'package:music_player/app/modules/library/views/tabs.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../controllers/library_controller.dart';

class LibraryView extends GetView<LibraryController> {
  const LibraryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Library'),
            centerTitle: true,
            //elevation: 2,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            bottom: const TabBar(
                indicatorColor: MyColors.secondary,
                isScrollable: true,
                tabs: [
                  Tab(text: 'Songs'),
                  Tab(text: 'Recents'),
                  Tab(text: 'Albums'),
                  Tab(text: 'Artist'),
                  Tab(text: 'Genres')
                ]),
          ),
          body: TabBarView(physics: const BouncingScrollPhysics(), children: [
            SongsTab(
                key: const Key('songTab'),
                query: controller.audioQuery
                    .querySongs(uriType: UriType.EXTERNAL)),
            const RecentTab(),
            AlbumTab(),
            ArtistTab(),
            GenreTab(),
          ])),
    );
  }
}
