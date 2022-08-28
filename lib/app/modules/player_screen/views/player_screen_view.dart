import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:we_slide/we_slide.dart';

import '../../../widgets/bg_container.dart';
import '../../../widgets/gradient_container.dart';
import '../controllers/player_controller.dart';
import 'art_widget.dart';
import 'controll_bottons.dart';

class PlayerScreenView extends GetWidget<PlayerController> {
  const PlayerScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.none,
      key: const Key('playScreen'),
      // background: Container(color: Colors.transparent),
      onDismissed: (direction) {
        Get.back();
      },
      child: BgContainer(
        child: GradientContainer(
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
                      onPressed: () {}, icon: const Icon(Icons.more_vert))
                ],
              ),
              body: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < constraints.maxHeight) {
                    return Column(
                      children: [
                        ArtWidget(
                          height: constraints.maxHeight * .4,
                        ),
                        const ControllButtons()
                      ],
                    );
                  } else {
                    return Row(children: [
                      ArtWidget(height: constraints.maxHeight * 0.80),
                      const ControllButtons()
                    ]);
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
