import 'package:get/get.dart';

import '../controllers/my_chargers_controller.dart';

class MyChargersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyChargersController>(
      () => MyChargersController(),
    );
  }
}
