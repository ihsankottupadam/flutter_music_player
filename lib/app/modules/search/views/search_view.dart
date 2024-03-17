import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:music_player/app/widgets/empty_view.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../widgets/bg_container.dart';
import '../../../widgets/song_tile.dart';
import '../../player_screen/controllers/player_controller.dart';
import '../controllers/search_controller.dart' as c;

class SearchView extends GetView<c.SearchController> {
  const SearchView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BgContainer(
      child: Scaffold(
          appBar: AppBar(
            title: CupertinoSearchTextField(
              itemColor: Colors.white,
              style: const TextStyle(color: Colors.white),
              placeholder: 'Serch Song',
              autofocus: true,
              onChanged: (val) => controller.search(val),
            ),
          ),
          body: Obx(
            () {
              var result = controller.results;
              if (result.isEmpty) {
                return const EmptyView(
                    icon: Icons.search, text: 'No Result Found');
              }
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: result.length,
                itemBuilder: (context, index) {
                  return SongTile(
                      song: result[index],
                      onTap: () {
                        Get.back();
                        Get.find<PlayerController>().playSongs(
                            result as List<SongModel>,
                            initialIndex: index);
                      });
                },
              );
            },
          )),
    );
  }
}
