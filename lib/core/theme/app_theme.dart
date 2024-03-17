import 'package:flutter/material.dart';
import 'package:music_player/core/utils/utils.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    primarySwatch: Utils.createMaterialColor(const Color(0xff64fed4)),
    brightness: Brightness.dark,
    useMaterial3: false,
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent, centerTitle: true),
    scaffoldBackgroundColor: Colors.transparent,
  );
}
