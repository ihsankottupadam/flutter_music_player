import 'package:flutter/material.dart';

class GradientWrapper extends StatelessWidget {
  const GradientWrapper({Key? key, required this.gradient, required this.child})
      : super(key: key);
  final LinearGradient gradient;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) => gradient.createShader(rect),
      child: child,
    );
  }
}
