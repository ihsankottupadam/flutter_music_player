import 'package:get/get.dart';

import '../controllers/queue_controller.dart';

class QueueBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QueueController>(
      () => QueueController(),
    );
  }
}
