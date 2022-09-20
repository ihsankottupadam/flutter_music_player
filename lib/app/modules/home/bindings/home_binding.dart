import 'package:get/get.dart';
import 'package:music_player/app/modules/library/controllers/library_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<LibraryController>(
      () => LibraryController(),
    );
  }
}
