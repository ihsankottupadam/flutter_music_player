import 'package:flutter/material.dart';

import '../../core/values/colors.dart';

class MiniPlayButton extends StatelessWidget {
  const MiniPlayButton({Key? key, required this.onPress}) : super(key: key);
  final VoidCallback onPress;
  final gradient = const LinearGradient(
      colors: [MyColors.secondary, Colors.white],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: ShaderMask(
        shaderCallback: (rect) => gradient.createShader(rect),
        child: const Icon(
          Icons.play_circle_fill,
          size: 30,
        ),
      ),
    );
  }
}
