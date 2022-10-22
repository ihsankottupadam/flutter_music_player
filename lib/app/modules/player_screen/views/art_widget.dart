import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../controllers/player_controller.dart';

class ArtWidget extends GetWidget<PlayerController> {
  const ArtWidget({
    Key? key,
    required this.height,
  }) : super(key: key);
  final double height;
  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: SizedBox(
      height: height * 1.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Align(
              alignment: Alignment.centerRight,
              child: StreamBuilder(
                  stream: controller.player.sequenceStateStream,
                  builder: (context, snapshot) {
                    return Text(
                        '${controller.currentIndex + 1}/${controller.songQueue.length}');
                  }),
            ),
          ),
          GetBuilder<PlayerController>(builder: (_) {
            if (!controller.hasPlaylist) {
              return SizedBox(height: height);
            }
            return LayoutBuilder(builder: (context, constrains) {
              final double artWidth = constrains.maxWidth;
              double dx = 0; //double tap dx
              return GestureDetector(
                onDoubleTapDown: (details) {
                  dx = details.globalPosition.dx;
                },
                onDoubleTap: () {
                  if (dx < artWidth / 3) {
                    controller.skipBackward();
                  } else if (dx > (artWidth * 2 / 3)) {
                    controller.skipForward();
                  }
                },
                child: CarouselSlider.builder(
                  carouselController: controller.carouselController,
                  itemCount: controller.songQueue.length,
                  itemBuilder: (context, int itemIndex, int pageViewIndex) {
                    return QueryArtworkWidget(
                      id: controller.songQueue[itemIndex].id,
                      artworkHeight: height,
                      artworkWidth: height,
                      type: ArtworkType.AUDIO,
                      artworkFit: BoxFit.cover,
                      artworkBorder: BorderRadius.circular(10),
                      nullArtworkWidget: Container(
                        width: height,
                        height: height,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0x55ffffff),
                              Color(0x15ffffff),
                              Color(0x33000000)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Icon(
                          Icons.music_note,
                          color: const Color(0xFF5AB2FA),
                          size: height * 0.25,
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                      initialPage: controller.currentIndex,
                      viewportFraction: 1,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, reason) {
                        if (reason == CarouselPageChangedReason.manual) {
                          controller.playfromQueue(index);
                        }
                      }),
                ),
              );
            });
          })
        ],
      ),
    ));
  }
}
