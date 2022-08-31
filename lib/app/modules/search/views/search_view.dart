import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:music_player/app/widgets/bg_container.dart';

import 'package:music_player/app/widgets/emptyview.dart';

import 'package:music_player/app/widgets/song_tile.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:we_slide/we_slide.dart';

import '../../player_screen/controllers/player_controller.dart';
import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BgContainer(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: CupertinoSearchTextField(
              itemColor: Colors.white,
              style: const TextStyle(color: Colors.white),
              placeholder: 'Serch Song',
              onChanged: (val) => controller.search(val),
            ),
            centerTitle: true,
          ),
          body: Obx(
            () {
              var result = controller.results.value;
              if (result.isEmpty) {
                return const EmptyViewN(
                  text: 'No result',
                  bottom: 'Found',
                );
              }
              return ListView.builder(
                itemCount: result.length,
                itemBuilder: (context, index) {
                  return SongTile(
                      song: result[index],
                      onTap: () {
                        Get.back();
                        Get.find<PlayerController>().setPlaylist(
                            result as List<SongModel>,
                            initialIndex: index);
                        Get.find<WeSlideController>().show();
                      });
                },
              );
            },
          )),
    );
  }
}
