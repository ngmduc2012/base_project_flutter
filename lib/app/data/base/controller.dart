

import 'package:get/get.dart';

import '../../widgets/dialog/loading_dialog.dart';

class BaseController extends GetxController {
  bool _isLoading = false;

  Future<void> showLoading() async {
    if (!_isLoading) {
      _isLoading = true;
      await Get.dialog(const LoadingDialog(), barrierDismissible: false);
      _isLoading = false;
    }
  }

  hideLoading() {
    if (_isLoading) {
      Get.back();
      _isLoading = false;
    }
  }
}
