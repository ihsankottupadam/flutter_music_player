import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:music_player/app/modules/home/controllers/home_controller.dart';

class BottomBar extends GetWidget<HomeController> {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xff2e619a), Color(0xff0a1832)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight)),
      child: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'favorites'),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books), label: 'Playlist'),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.5), //Colors.grey,
        onTap: (index) {},
      ),
    );
  }
}
