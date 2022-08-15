import 'package:get/get.dart';

import '../controllers/album_screen_controller.dart';

class AlbumScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlbumScreenController>(
      () => AlbumScreenController(),
    );
  }
}
