import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/app/modules/player_screen/controllers/timer_controller.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class TimerDialog extends GetWidget<TimerController> {
  const TimerDialog({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final barSize = math.min(size.width, size.height) * .5;
    return AlertDialog(
      contentPadding: const EdgeInsets.only(top: 30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Timer',
            style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold),
          ),
          Obx(() => Switch(
                value: controller.enabled.value,
                onChanged: controller.toggle,
              ))
        ],
      ),
      actions: [
        _cancelButton(context),
      ],
      content: SleekCircularSlider(
          min: 1,
          max: 240,
          initialValue: controller.enabledValue,
          onChange: controller.onPickerChange,
          appearance: CircularSliderAppearance(
            size: barSize,
            animationEnabled: false,
            customWidths:
                CustomSliderWidths(progressBarWidth: 10, trackWidth: 6),
            customColors: CustomSliderColors(
              progressBarColors: const [
                Colors.blue,
                Color(0xfffb84ff),
                Color(0xff58f9a2),
              ],
              trackColor: const Color(0x33000000),
            ),
            infoProperties: InfoProperties(
              mainLabelStyle:
                  const TextStyle(color: Colors.white, fontSize: 22),
              modifier: controller.formatMin,
            ),
          )),
    );
  }

  _cancelButton(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Cancel'));
  }
}
