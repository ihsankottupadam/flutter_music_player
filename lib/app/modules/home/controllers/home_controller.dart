import 'package:get/get.dart';
import 'package:we_slide/we_slide.dart';

class HomeController extends GetxController {
  WeSlideController slideController = WeSlideController();

  @override
  void onInit() {
    Get.put(slideController);
    super.onInit();
  }
}
