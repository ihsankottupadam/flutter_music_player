import 'package:get/get.dart';
import 'package:music_player/app/controllers/ui_controller.dart';
import 'package:music_player/app/modules/home/controllers/home_controller.dart';
import 'package:music_player/app/modules/player_screen/controllers/player_controller.dart';

class InitialBindins extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.put(PlayerController());
    Get.put(UiController());
  }
}
