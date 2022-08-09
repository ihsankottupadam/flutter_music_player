import 'dart:ui';

import 'package:flutter/material.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({Key? key, required this.onTap}) : super(key: key);
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5.0,
          sigmaY: 5.0,
        ),
        child: GestureDetector(
          onTap: () => onTap(),
          child: Container(
            width: double.infinity,
            height: 100,
          ),
        ));
  }
}
