import 'package:get/get.dart';

import 'controller.dart';

class WelcomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(WelcomeController());
  }
}
