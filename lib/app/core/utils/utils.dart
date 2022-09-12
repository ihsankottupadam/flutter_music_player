import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';

class Utils {
  static Future<Color> getColorfromImage(
      {required ImageProvider imageProvider}) async {
    PaletteGenerator paletteGenerator;
    paletteGenerator = await PaletteGenerator.fromImageProvider(imageProvider);
    final Color dominantColor =
        paletteGenerator.dominantColor?.color ?? Colors.black;
    final Color darkMutedColor =
        paletteGenerator.darkMutedColor?.color ?? Colors.black;
    final Color lightMutedColor =
        paletteGenerator.lightMutedColor?.color ?? dominantColor;
    if (dominantColor == darkMutedColor) {
      return lightMutedColor;
    }

    return dominantColor;
  }

  static showSnackBar(
      {required String text,
      BuildContext? context,
      bool isError = false,
      double botom = 125}) {
    ScaffoldMessenger.of(Get.context!)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
            padding: const EdgeInsets.all(16),
            content: Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
            elevation: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor:
                isError ? Colors.red.withOpacity(1) : const Color(0xf5181818),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: botom, right: 14, left: 14)),
      );
  }

  static String getFileSizeString({required int bytes, int decimals = 0}) {
    const suffixes = ["b", "kb", "mb", "gb", "tb"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
  }
}
