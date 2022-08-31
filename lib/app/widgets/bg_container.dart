import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../controllers/ui_controller.dart';

class BgContainer extends StatelessWidget {
  BgContainer({Key? key, this.child}) : super(key: key);
  final Widget? child;
  final _controller = Get.find<UiController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'), fit: BoxFit.fill),
      ),
      child: Obx(
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
      ),
    );
  }
}
