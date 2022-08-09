import 'package:flutter/material.dart';

import 'package:palette_generator/palette_generator.dart';

class Utils {
  static Future<List<Color>> getColorsfromImage({
    required ImageProvider imageProvider,
  }) async {
    PaletteGenerator paletteGenerator;
    paletteGenerator = await PaletteGenerator.fromImageProvider(imageProvider);
    final Color dominantColor =
        paletteGenerator.dominantColor?.color ?? Colors.black;
    final Color darkMutedColor =
        paletteGenerator.darkMutedColor?.color ?? Colors.black;
    final Color lightMutedColor =
        paletteGenerator.lightMutedColor?.color ?? dominantColor;
    if (dominantColor.computeLuminance() < darkMutedColor.computeLuminance()) {
      // checks if the luminance of the darkMuted color is > than the luminance of the dominant
      return [
        darkMutedColor,
        dominantColor,
      ];
    } else if (dominantColor == darkMutedColor) {
      // if the two colors are the same, it will replace dominantColor by lightMutedColor

      return [
        lightMutedColor,
        darkMutedColor,
      ];
    } else {
      return [
        dominantColor,
        darkMutedColor,
      ];
    }
  }
}
