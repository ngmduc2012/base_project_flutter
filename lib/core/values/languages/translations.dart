import 'package:get/get.dart';

import 'trans/en_us.dart';
import 'trans/vi_vn.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'vi_VN': vi,
      };

  // common
  static String get errorSever => 'errorSever'.tr;

  static String get cancel => "cancel".tr;

  static String get language => "language".tr;

  static String get camera => 'camera'.tr;

  static String get library => "library".tr;

  static String get settings => "settings".tr;

  // QR code Scanner

  static String get qrCodeScanner => "qrCodeScanner".tr;

  static String get qrCodeGuide => "qrCodeGuide".tr;

  static String get h => 'h'.tr;

  static String get m => 'm'.tr;

  static String get titlePermission => "titlePermission".tr;

  static String get detailPermission => "detailPermission".tr;

  static String incorrectFormat(String label) => "incorrectFormat".trParams({
        'label': label,
      });
}
