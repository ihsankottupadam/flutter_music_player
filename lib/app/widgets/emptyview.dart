import 'package:flutter/material.dart';

class EmptyViewN extends StatelessWidget {
  const EmptyViewN({Key? key, required this.text, this.bottom})
      : super(key: key);
  final String text;
  final String? bottom;
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
                text,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              if (bottom != null)
                Text(
                  bottom!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 28),
                ),
            ],
          ),
          const Text(
            '!',
            style: TextStyle(fontSize: 70),
          )
        ],
      ),
    );
  }
}
