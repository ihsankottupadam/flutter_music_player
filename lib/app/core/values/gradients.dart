import 'package:flutter/material.dart';

class Gradients {
  static const error = LinearGradient(
      colors: [Colors.red, Color(0x33FFFFFF)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
  static const success = LinearGradient(
      colors: [Colors.green, Color(0x33FFFFFF)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
}
