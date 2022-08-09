import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UiController extends GetxController {
  var curDominantColor = const Color(0x33FF00EA).obs;

  setbgColor(Color color) {
    curDominantColor.value = color;
  }

  setToDefaultColor() {
    curDominantColor.value = const Color(0x33FF00EA);
  }
}
