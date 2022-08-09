import 'package:flutter/material.dart';

class ControllButton extends StatelessWidget {
  const ControllButton(
      {Key? key,
      required this.icon,
      required this.size,
      required this.color,
      required this.onPressed})
      : super(key: key);
  final IconData icon;
  final double size;
  final Color color;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0x332196F3),
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(5),
      child: IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: size,
            color: color,
          )),
    );
  }
}
