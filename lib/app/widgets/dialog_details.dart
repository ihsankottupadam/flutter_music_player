import 'package:flutter/material.dart';
import 'package:music_player/app/core/utils/utils.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongDetailDialog extends StatelessWidget {
  const SongDetailDialog({Key? key, required this.song}) : super(key: key);
  final SongModel song;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ))
      ],
      title: Text(
        'Song Info',
        style: TextStyle(color: Theme.of(context).colorScheme.secondary),
      ),
      content: Text('''
Title: ${song.title}

Artist:  ${song.artist}

Album:  ${song.album}

Composer:  ${song.composer}

Size : ${Utils.getFileSizeString(bytes: song.size, decimals: 2)}'''),
    );
  }
}
