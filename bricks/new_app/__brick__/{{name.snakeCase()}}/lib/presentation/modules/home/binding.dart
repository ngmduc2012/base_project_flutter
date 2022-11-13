import 'package:get/get.dart';
import '../../../app/services/localization.dart';
import 'controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    // Get.put(ThemeService());
    Get.put(LocalizationService());
    Get.put(HomeController());
  }
}
