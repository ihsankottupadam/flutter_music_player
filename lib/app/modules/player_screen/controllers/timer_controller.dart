import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'player_controller.dart';

class TimerController extends GetxController {
  RxBool enabled = false.obs;
  double enabledValue = 30;
  double seekVal = 30;
  Timer? timer;
  RxString timeText = '0 Hr 0 Min'.obs;

  toggle(val) {
    val ? enable() : diasable();
  }

  onPickerChange(double val) {
    timeText.value = formatMin(val);
    seekVal = val;
  }

  enable() {
    enabled.value = true;
    enabledValue = seekVal;
    timer = Timer(Duration(minutes: enabledValue.round()), () {
      Get.find<PlayerController>().player.stop();
      enabled.value = false;
    });
    Fluttertoast.showToast(msg: 'Timer set for ${formatMin(enabledValue)}');
  }

  diasable() {
    enabled.value = false;
    timer?.cancel();
    Fluttertoast.showToast(msg: 'Timer off');
  }

  String formatMin(double val) =>
      '${val >= 60 ? '${val ~/ 60} Hrs ' : ''}${(val ~/ 1) % 60} Min';
}
