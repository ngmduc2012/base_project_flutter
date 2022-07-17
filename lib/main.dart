import 'package:base_project/routes/pages.dart';
import 'package:base_project/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

import 'app/data/services/localization.dart';
import 'app/module/welcome/binding.dart';
import 'core/values/languages/translations.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  /// test perview on other devices
  /// Kiếm tra giao diện hiển thị trên các thiết bị khác
  /// follow: https://pub.dev/packages/device_preview
  runApp(
      // DevicePreview(
      //     builder: (context) =>
      GetMaterialApp(
    ///Giao diện tối.
    darkTheme: ThemeData.dark(),
    themeMode: ThemeMode.system,
    initialBinding: WelcomeBinding(),
    debugShowCheckedModeBanner: false,
    getPages: AppPages.pages,
    locale: LocalizationService.getLocaleFromLanguage(),
    fallbackLocale: LocalizationService.fallbackLocale,
    translations: AppTranslations(),
    initialRoute: Routes.WELCOME,
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [Locale('vi'), Locale('en')],
  )
      // )
      );
}
