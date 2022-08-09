import 'package:flutter/cupertino.dart';

class BgContainer extends StatelessWidget {
  const BgContainer({Key? key, this.child}) : super(key: key);
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'), fit: BoxFit.fill),
      ),
      child: child,
    );
  }
}
