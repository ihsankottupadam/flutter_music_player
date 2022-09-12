import 'package:flutter/material.dart';
import 'package:music_player/app/widgets/empty_view.dart';

class EmptySongs extends EmptyView {
  const EmptySongs({Key? key})
      : super(key: key, icon: Icons.music_note, text: 'No Songs Found');
}
