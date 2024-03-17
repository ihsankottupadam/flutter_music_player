import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/app/modules/player_screen/controllers/lyrics_controller.dart';
import 'package:music_player/app/modules/player_screen/controllers/player_controller.dart';
import 'package:music_player/app/widgets/empty_view.dart';
import 'package:music_player/app/widgets/mini_player.dart';

class LyricsWidget extends GetWidget<LyricsController> {
  const LyricsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LyricsController>(
      builder: (controller) {
        return Column(
          children: [
            Expanded(child: _getView()),
            MiniPlayer(
              onTap: () {
                Get.find<PlayerController>().toggleLyricsView();
              },
            )
          ],
        );
      },
    );
  }

  Widget _getView() {
    if (controller.lyrics == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text('Serching Lyrics')
          ],
        ),
      );
    }
    if (controller.lyrics == 'empty') {
      return const EmptyView(icon: Icons.lyrics, text: 'No Lyrics Found');
    }
    if (controller.lyrics == 'No Connection') {
      return const EmptyView(icon: Icons.error, text: 'No Network');
    }
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      physics: const BouncingScrollPhysics(),
      child: Text(
        controller.lyrics ?? '',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18, height: 1.8),
      ),
    );
  }
}
