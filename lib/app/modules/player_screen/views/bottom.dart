import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../controllers/player_controller.dart';
import 'controll_bottons.dart';
import 'widgets/lyrics_widget.dart';

class BottomView extends GetWidget<PlayerController> {
  const BottomView({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FlipCard(
            flipOnTouch: false,
            controller: controller.flipCardController,
            direction: FlipDirection.VERTICAL,
            front: const ControllButtons(),
            back: const LyricsWidget()));
  }
}
