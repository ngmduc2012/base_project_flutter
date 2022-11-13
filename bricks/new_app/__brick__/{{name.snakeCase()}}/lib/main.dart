import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/core/routes/pages.dart';
import 'app/core/routes/routes.dart';
import 'app/core/values/languages/translations.dart';
import 'app/services/localization.dart';
import 'presentation/modules/welcome/binding.dart';
import 'package:device_preview/device_preview.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await GetStorage.init();
  FlutterNativeSplash.preserve(
      widgetsBinding: WidgetsFlutterBinding.ensureInitialized());

  /// Firebase ========================================
  await Firebase.initializeApp(
    // name: "abcd",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// =================================================
  Get.put(LocalizationService());
  /// test perview on other devices
  /// Kiếm tra giao diện hiển thị trên các thiết bị khác
  /// follow: https://pub.dev/packages/device_preview
  runApp(DevicePreview(
      // enabled: true,
      enabled: false,
      builder: (context) => GetMaterialApp(
            ///Giao diện tối.
            initialBinding: WelcomeBinding(),
            darkTheme: LocalizationService.to.darkTheme,
            themeMode: LocalizationService.to.themeMode,
            title: "{{name.titleCase()}}",
            debugShowCheckedModeBanner: false,
            getPages: AppPages.pages,
            locale: LocalizationService.getLocaleFromLanguage(),
            fallbackLocale: LocalizationService.fallbackLocale,
            translations: AppTranslations(),
            initialRoute: Routes.WELCOME,
            localizationsDelegates: const [
              FormBuilderLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales:
                FormBuilderLocalizations.delegate.supportedLocales,
          )));
}
