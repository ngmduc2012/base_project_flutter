import 'package:get/get.dart';
import '../../data/services/localization.dart';
import 'controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(LocalizationService());
    Get.put(HomeController());
  }
}
