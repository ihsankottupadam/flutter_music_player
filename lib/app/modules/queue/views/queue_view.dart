import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/app/widgets/mini_player.dart';

import '../../../widgets/bg_container.dart';
import '../../../widgets/song_tile.dart';
import '../../player_screen/controllers/player_controller.dart';
import '../controllers/queue_controller.dart';

class QueueView extends GetView<QueueController> {
  QueueView({Key? key}) : super(key: key);
  final PlayerController playerController = Get.find();
  @override
  Widget build(BuildContext context) {
    return BgContainer(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Song Queue'),
            backgroundColor: Colors.transparent,
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                    stream: playerController.player.sequenceStateStream,
                    builder: (context, snapshot) {
                      return ReorderableListView.builder(
                        scrollController: controller.scrollController,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            //to avoid duplicated key wen same son added to queue
                            key: ValueKey(
                                '$index,${controller.songQueue[index].id}'),
                            direction: playerController.currentIndex == index
                                ? DismissDirection.none
                                : DismissDirection.horizontal,
                            onDismissed: (direction) =>
                                controller.removeFromQueue(index),
                            child: SongTile(
                              song: controller.songQueue[index],
                              isSelected:
                                  playerController.currentIndex == index,
                              onTap: () {
                                controller.playerController
                                    .playfromQueue(index);
                              },
                              showMenu: false,
                            ),
                          );
                        },
                        itemCount: controller.songQueue.length,
                        onReorder: controller.reOrderQueue,
                        proxyDecorator: proxyDecorator,
                      );
                    }),
              ),
              MiniPlayer(onTap: () => Get.back())
            ],
          )),
    );
  }

  Widget proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        final double animValue = Curves.easeInOut.transform(animation.value);
        final double elevation = lerpDouble(0, 3, animValue)!;
        return Material(
          borderRadius: BorderRadius.circular(10),
          elevation: elevation,
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
          shadowColor: Colors.black,
          child: Container(child: child),
        );
      },
      child: child,
    );
  }
}
