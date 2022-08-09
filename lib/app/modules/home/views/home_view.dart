import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:music_player/app/modules/library/views/library_view.dart';
import 'package:music_player/app/modules/player_screen/views/player_screen_view.dart';
import 'package:music_player/app/widgets/bg_container.dart';
import 'package:music_player/app/widgets/gradient_container.dart';
import 'package:music_player/app/widgets/mini_player.dart';
import 'package:we_slide/we_slide.dart';

import '../controllers/home_controller.dart';
import 'bottom_bar.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WeSlideController controller = WeSlideController();
    final double panelMinSize = 125.0;
    final double panelMaxSize = MediaQuery.of(context).size.height;
    return BgContainer(
      child: GradientContainer(
        child: Scaffold(
          body: WeSlide(
            backgroundColor: Colors.transparent,
            controller: controller,
            panelMinSize: panelMinSize,
            panelMaxSize: panelMaxSize,
            overlayOpacity: 0.9,
            overlay: true,
            isDismissible: true,
            body: const LibraryView(),
            panelHeader: MiniPlayer(
              onTap: () {
                controller.show();
              },
            ),
            panel: MiniPlayer(onTap: () {}),
            footer: const BottomBar(),
            blur: true,
          ),
        ),
      ),
    );
  }
}
