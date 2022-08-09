import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  const EmptyView(this.text1, this.text2, this.text3, {Key? key})
      : super(key: key);
  final bool useWhite = false;
  final String text1;
  final String text2;
  final String text3;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                text1,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 15,
                  color: useWhite
                      ? Colors.white
                      : Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 5),
            Column(
              children: [
                Text(
                  text2,
                  style: TextStyle(
                    fontSize: 42,
                    color: useWhite
                        ? Colors.white
                        : Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  text3,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: useWhite ? Colors.white : null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
