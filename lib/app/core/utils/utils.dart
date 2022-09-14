import 'dart:math';

import 'package:flutter/material.dart';
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

  static String getFileSizeString({required int bytes, int decimals = 0}) {
    const suffixes = ["b", "kb", "mb", "gb", "tb"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
  }
}
