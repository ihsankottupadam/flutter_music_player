import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/app/modules/home/controllers/home_controller.dart';

class BottomBar extends GetWidget<HomeController> {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(
            icon: Icon(Icons.library_books), label: 'Your Library'),
      ],
      elevation: 0,
      backgroundColor: colorTheme.surface,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: colorTheme.onPrimary,
      unselectedItemColor: colorTheme.onPrimary.withOpacity(0.5), //Colors.grey,
      onTap: (index) {},
    );
  }
}
