
import 'package:get/get.dart';

import '../../../app/services/localization.dart';
import 'controller.dart';


class EditProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(LocalizationService());
    Get.put(EditProfileController());
  }
}
