import 'dart:developer' as d;
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import '../../../data/modles/user.dart';
import '../../../app/services/local_storage_get.dart';
import '../../../app/types/key.dart';
import '../../../app/core/routes/routes.dart';

class WelcomeController extends GetxController {
  @override
  void onInit() {
    FlutterNativeSplash.remove();

    /// Auto login after duration.
    // Future.delayed(const Duration(milliseconds: 864), () {
    //   Get.offAllNamed(Routes.HOME);
    // });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    final json = _storage.read(USER_CONTROLLER);
    if (json != null) {
      var user = User.fromJson(json);
      if (user != null) {
        Get.offAllNamed(Routes.HOME);
      }
    }
  }

  final LocalStorage _storage = LocalStorage.get;



  var initialIndex  = 2;
}
