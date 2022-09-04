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

  static showSnackBar(
      {required BuildContext context,
      required String text,
      bool isError = false}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
            content: Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: isError ? Colors.red : Colors.grey.shade700,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height - 100,
                right: 20,
                left: 20)),
      );
  }
}
