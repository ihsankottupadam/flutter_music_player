import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/app/modules/player_screen/controllers/player_controller.dart';

class VolumeBar extends GetWidget<PlayerController> {
  const VolumeBar({Key? key, required this.heiht}) : super(key: key);
  final double heiht;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: heiht,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade900.withOpacity(.9)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: StreamBuilder<double>(
            stream: controller.player.volumeStream,
            builder: (context, snapshot) {
              double voulume = snapshot.data ?? controller.player.volume;
              return Column(
                children: [
                  Expanded(
                      child: RotatedBox(
                    quarterTurns: -1,
                    child: ShaderMask(
                      shaderCallback: (rect) => const LinearGradient(
                              colors: [Color(0xff58f9a2), Color(0xfffb84ff)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight)
                          .createShader(rect),
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        backgroundColor: Colors.white.withOpacity(0.2),
                        value: voulume,
                      ),
                    ),
                  )),
                  const SizedBox(height: 10),
                  Icon(voulume == 0 ? Icons.volume_off : Icons.volume_up)
                ],
              );
            }),
      ),
    );
  }
}
