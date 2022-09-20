import 'package:flutter/material.dart';

class SettingsBg extends StatelessWidget {
  const SettingsBg({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'), fit: BoxFit.fill),
      ),
      child: DecoratedBox(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0x11FF00EA), Color(0x77000000), Colors.black],
                stops: [0, 0.3, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: child,
      ),
    );
  }
}
