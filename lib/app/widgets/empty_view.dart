import 'dart:ui';

import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  const EmptyView(
      {Key? key,
      required this.icon,
      required this.text,
      this.iconColor = Colors.white})
      : super(key: key);
  final IconData icon;
  final Color iconColor;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: 40,
                  left: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0x22ffffff),
                          border:
                              Border.all(color: Colors.white.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0x0f000000),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.2)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 75,
                      height: 75,
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Icon(icon, size: 40, color: iconColor)),
                Positioned(
                  top: -10,
                  left: -10,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0x22ffffff),
                          border:
                              Border.all(color: Colors.white.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            text,
            style: TextStyle(
                fontSize: 17,
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
