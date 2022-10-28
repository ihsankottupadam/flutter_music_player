import 'package:flutter/material.dart';

class AnimatedSlider extends StatelessWidget {
  const AnimatedSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.animationDuration = const Duration(milliseconds: 300),
    this.onChangeStart,
    this.onChangeEnd,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.label,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.animationCurve = Curves.linear,
  });
  final Duration animationDuration;
  final Curve animationCurve;
  final double value;
  final ValueChanged<double>? onChanged;
  final ValueChanged<double>? onChangeStart;
  final ValueChanged<double>? onChangeEnd;
  final double min;

  final double max;
  final int? divisions;
  final String? label;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? thumbColor;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: min, end: value),
      duration: animationDuration,
      curve: animationCurve,
      builder: (context, double value, child) {
        return Slider(
          value: value,
          onChanged: onChanged,
          activeColor: activeColor,
          divisions: divisions,
          inactiveColor: activeColor,
          label: label,
          min: min,
          max: max,
          onChangeStart: onChangeStart,
          onChangeEnd: onChangeEnd,
          thumbColor: thumbColor,
        );
      },
    );
  }
}
