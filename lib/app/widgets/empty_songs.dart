import 'package:flutter/material.dart';

class EmptySongs extends StatelessWidget {
  const EmptySongs({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'No Songs',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              const Text(
                'Found',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
            ],
          ),
          const Icon(
            Icons.music_note,
            size: 45,
          )
        ],
      ),
    );
  }
}
