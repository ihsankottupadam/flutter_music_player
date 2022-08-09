import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music_player/app/widgets/bg_container.dart';

class TranScaffold extends StatelessWidget {
  const TranScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BgContainer(child: Scaffold());
  }
}
