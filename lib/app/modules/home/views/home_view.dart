import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:music_player/app/modules/home/views/favories.dart';
import 'package:music_player/app/modules/home/views/playlist_screen.dart';
import 'package:music_player/app/modules/library/views/library_view.dart';
import 'package:music_player/app/modules/player_screen/controllers/player_controller.dart';
import 'package:music_player/app/modules/player_screen/views/player_screen_view.dart';
import 'package:music_player/app/widgets/bg_container.dart';
import 'package:music_player/app/widgets/gradient_container.dart';
import 'package:music_player/app/widgets/mini_player.dart';
import 'package:we_slide/we_slide.dart';

import '../controllers/home_controller.dart';
import 'bottom_bar.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WeSlideController slideController = controller.slideController;
    final PlayerController playerController = Get.find();
    const double panelMinSize = 120;
    final double panelMaxSize = MediaQuery.of(context).size.height;
    return BgContainer(
      child: GradientContainer(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Obx(
            () {
              bool showMiniPlayer = playerController.showMiniPlayer.value;
              return WeSlide(
                backgroundColor: Colors.transparent,
                controller: slideController,
                panelMinSize: showMiniPlayer ? panelMinSize : 0,
                panelMaxSize: panelMaxSize,
                overlayOpacity: 0.9,
                overlay: true,
                isDismissible: true,
                body: ScreenView(),
                panelHeader: showMiniPlayer
                    ? MiniPlayer(
                        onTap: () {
                          slideController.show();
                        },
                      )
                    : null,
                panel: const PlayerScreenView(),
                footer: const BottomBar(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ScreenView extends GetWidget<HomeController> {
  ScreenView({Key? key}) : super(key: key);
  final screens = [NestedSCreen(), FavoriteScreen(), PlaylistScreen()];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _handleBack,
        child: Obx(() => screens[controller.curScreen.value]));
  }

  Future<bool> _handleBack() async {
    WeSlideController slideController = Get.find<WeSlideController>();
    if (slideController.isOpened) {
      slideController.hide();
      return false;
    }

    return true;
  }
}

class NestedSCreen extends StatelessWidget {
  NestedSCreen({
    Key? key,
  }) : super(key: key);
  final _libraryKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handleBack,
      child: Navigator(
          key: _libraryKey,
          onGenerateRoute: (route) => MaterialPageRoute(
                settings: route,
                builder: (context) => const LibraryView(),
              )),
    );
  }

  Future<bool> _handleBack() async {
    // WeSlideController slideController = Get.find<WeSlideController>();
    // if (slideController.isOpened) {
    //   slideController.hide();
    //   return false;
    // }
    if (_libraryKey.currentState != null &&
        _libraryKey.currentState!.canPop()) {
      _libraryKey.currentState!.pop();
      return false;
    }

    return true;
  }
}
