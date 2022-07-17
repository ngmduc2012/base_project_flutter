import 'dart:developer' as d;

import 'package:get/get.dart';

import '../../../routes/routes.dart';

class WelcomeController extends GetxController {
  @override
  void onInit() {
    Future.delayed(const Duration(milliseconds: 864), () {
      Get.offAllNamed(Routes.HOME);
    });
    super.onInit();
  }
}
