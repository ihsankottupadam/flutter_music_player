import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/app/modules/equalizer/views/eq_example.dart';
import 'package:music_player/app/routes/app_pages.dart';
import 'package:music_player/app/widgets/bg_container.dart';
import 'package:music_player/app/modules/player_screen/views/widgets/dialog_details.dart';
import 'package:we_slide/we_slide.dart';

import '../../../widgets/mypopupmenu.dart';
import '../../equalizer/controllers/equalizer_controller.dart';
import '../../library/controllers/library_controller.dart';
import '../controllers/player_controller.dart';
import 'art_widget.dart';
import 'controll_bottons.dart';

class PlayerScreenView extends GetWidget<PlayerController> {
  const PlayerScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BgContainer(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  //Get.back();
                  Get.find<WeSlideController>().hide();
                },
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                tooltip: 'Back'),
            actions: [
              IconButton(
                  onPressed: () {
                    Get.put<EqualizerController>(EqualizerController());
                    Get.toNamed(Routes.EQUALIZER);
                  },
                  icon: const Icon(Icons.equalizer_sharp)),
              _buldMenu(context)
            ],
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < constraints.maxHeight) {
                return Column(
                  children: [
                    ArtWidget(
                      height: size.height * .4,
                    ),
                    const ControllButtons()
                  ],
                );
              } else {
                return Row(children: [
                  ArtWidget(height: size.height * 0.80),
                  const ControllButtons()
                ]);
              }
            },
          ),
        ),
      ),
    );
  }

  MyPopupMenu _buldMenu(BuildContext context) {
    return MyPopupMenu(
        items: [
          MyPopupItem(id: 0, title: 'Play All', icon: Icons.play_arrow_rounded),
          MyPopupItem(
              id: 1, title: 'Song info', icon: Icons.info_outline_rounded),
          MyPopupItem(id: 2, title: 'Settings', icon: Icons.settings)
        ],
        onItemSelected: (id) {
          switch (id) {
            case 0:
              final songs = Get.find<LibraryController>().songs;
              Get.find<PlayerController>().playSongs(songs, showPanel: false);
              break;
            case 1:
              showDialog(
                  context: context,
                  builder: (context) => SongDetailDialog(
                      song: Get.find<PlayerController>().currentSong.value));
              break;
            case 2:
              Get.toNamed(Routes.SETTINGS);
              break;
            default:
          }
        });
  }
}
