import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_custom_slider/flutter_custom_slider.dart';

import 'package:get/get.dart';

import 'package:music_player/app/widgets/animated_slider.dart';
import 'package:music_player/app/widgets/bg_container.dart';

import '../controllers/equalizer_controller.dart';

class EqualizerView extends GetWidget<EqualizerController> {
  const EqualizerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    controller.loadView();
    return BgContainer(
      child: Scaffold(
          backgroundColor: Colors.black.withOpacity(0.3),
          appBar: AppBar(
            title: const Text('Equalizer'),
            centerTitle: true,
            actions: [
              Obx(() => Switch(
                  value: controller.enabled.value,
                  onChanged: controller.setEnabled))
            ],
          ),
          body: GetBuilder<EqualizerController>(builder: (controller) {
            int id = -1;
            return Column(
              children: [
                const SizedBox(height: 15),
                if (controller.presets != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          labelText: 'Available Presets',
                          border: OutlineInputBorder(),
                        ),
                        value: controller.selectedPresest,
                        items: controller.presets!
                            .map((String val) => DropdownMenuItem<String>(
                                value: val, child: Text(val)))
                            .toList(),
                        onChanged: controller.setPreset),
                  ),
                Expanded(
                  child: Center(
                    child: SizedBox(
                        height: size.height * .4,
                        width: double.infinity,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: controller.bandFreqs!.map((e) {
                                id++;
                                return EqSlider(
                                  freq: e,
                                  bandId: id,
                                  c: controller,
                                );
                              }).toList(),
                            ))),
                  ),
                ),
              ],
            );
          })),
    );
  }
}

class EqSlider extends GetWidget<EqualizerController> {
  const EqSlider({
    super.key,
    required this.freq,
    required this.bandId,
    this.c,
  });
  final int freq;
  final int bandId;
  final GetxController? c;
  @override
  Widget build(BuildContext context) {
    log('reb');
    return Expanded(
      child: Column(
        children: [
          RotatedBox(
            quarterTurns: -1,
            child: Obx(
              () {
                int value = controller.bandLevels[bandId].value;
                return FlutterCustomSlider(
                  imagePath: 'assets/images/vert_thumb.png',
                  thumbHeight: 20,
                  thumbWidth: 20,
                  trackBorder: 2,
                  trackHeight: 8,
                  activeTrackGradient: const LinearGradient(
                      colors: [Color(0xff58f9a2), Color(0xfffb84ff)]),
                  inactiveTrackGradient: LinearGradient(
                      colors: [Colors.grey.shade600, Colors.grey.shade900]),
                  slider: AnimatedSlider(
                      min: controller.min,
                      max: controller.max,
                      value: value.toDouble(),
                      onChanged: (val) {
                        controller.setBandLevel(bandId, val.toInt());
                      }),
                );
              },
            ),
          ),
          Text('${freq ~/ 1000} Hz')
        ],
      ),
    );
  }
}
