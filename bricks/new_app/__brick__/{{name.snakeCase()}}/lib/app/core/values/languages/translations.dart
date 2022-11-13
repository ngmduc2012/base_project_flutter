import 'package:get/get.dart';

import 'trans/en_us.dart';
import 'trans/vi_vn.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': en,
    'vi_VN': vi,
  };

  /// Widget
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

  static String get connectFailed => 'connectFailed'.tr;

  /// Welcome
  static String get login => 'login'.tr;

  static String get signUp => 'signUp'.tr;

  static String get welcome => 'welcome'.tr;

  /// Home
  static String get logout => 'logout'.tr;

  static String get changePass => 'changePass'.tr;

  /// SIGN_UP
  static String get selectAvatar => 'selectAvatar'.tr; //"Chọn avatar"

  static String get takeThePhoto => 'takeThePhoto'.tr; //Chụp ảnh

  static String get openImage => 'openImage'.tr; //"Xem ảnh"

  static String get userName => 'userName'.tr; //'User Name'

  static String get email => 'email'.tr; //'Email'

  static String get password => 'password'.tr; //'Password'

  static String get rePassword => 'rePassword'.tr; //'Re-Password'

  static String get name => 'name'.tr; //'Name'

  static String get birthDay => 'birthDay'.tr; //'Birth Day'

  static String get phoneNumber => 'phoneNumber'.tr; //'Phone Number'

  static String get errorRePasswordForm =>
      'errorRePasswordForm'.tr; //'Mật khẩu không khớp'

  static String get cropper => 'cropper'.tr; //'cropper'

  static String get male => 'male'.tr; //'Male'

  static String get female => 'female'.tr; //'Female'

  static String get other => 'other'.tr; //'Other'

  static String get admin => 'admin'.tr; //'Admin'

  static String get number => 'number'.tr; //'Number'

  /// LOGIN

  static String get rememberPassword => 'rememberPassword'.tr;//''Nhớ mật khẩu''

  static String get forgetPassword => 'forgetPassword'.tr; //'"Quên mật khẩu?"'

  /// SETTING

  static String get vietnamese => 'vietnamese'.tr;

  static String get english => 'english'.tr;

  static String get darkMode => 'darkMode'.tr;

  /// EDIT

  static String get editProfile => 'editProfile'.tr;

  /// Search
  static String get search => 'search'.tr;

  /// Dialog
  static String get success => 'success'.tr;

  static String get failure => 'failure'.tr;

  static String get successRegister => 'successRegister'.tr;

  static String get loading => 'loading'.tr;

}
