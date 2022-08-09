import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:music_player/app/controllers/ui_controller.dart';

class GradientContainer extends StatelessWidget {
  GradientContainer({Key? key, this.child}) : super(key: key);
  final Widget? child;
  final _controller = Get.find<UiController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedContainer(
        duration: const Duration(seconds: 1),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              _controller.curDominantColor.value,
              const Color(0x331473e9),
              const Color(0x330E2485),
            ],
          ),
        ),
        child: child,
      ),
    );
  }
}
