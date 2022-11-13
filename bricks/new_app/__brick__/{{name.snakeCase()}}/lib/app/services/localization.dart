import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import '../../data/modles/color_select.dart';
import '../utils/keys.dart';
import 'local_storage_get.dart';

class LocalizationService extends GetxService {
  static LocalizationService get to => Get.find();

  static final localStorage = LocalStorage.get;

  static const fallbackLocale = Locale('en', 'US');

  static final langCodes = [
    'en',
    'vi',
  ];

  static final locales = [
    const Locale('en', 'US'),
    const Locale('vi', 'VN'),
  ];

  static final langs = LinkedHashMap.from({
    'en': 'English',
    'vi': 'Tiếng Việt',
  });

  static Locale getLocaleFromLanguage({String? langCode}) {
    var lang = langCode ??
        localStorage.read(LocalStorageKeys.LANG_CODE) as String? ??
        Get.deviceLocale?.languageCode;

    for (int i = 0; i < langCodes.length; i++) {
      if (lang == langCodes[i]) return locales[i];
    }

    return Get.locale ?? fallbackLocale;
  }

  final locale = getLocaleFromLanguage().obs;

  toggleLocale(langCode) {
    changeLocale(langCode);
  }

  void changeLocale(String langCode) {
    locale.value = getLocaleFromLanguage(langCode: langCode);
    localStorage.write(LocalStorageKeys.LANG_CODE, locale.value.languageCode);
    Get.updateLocale(locale.value);
  }

  /// Detect Dark Mode: https://stackoverflow.com/a/56307575/10621168
  ThemeMode themeMode =
      SchedulerBinding.instance.window.platformBrightness == Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light;
  ThemeData? darkTheme = ThemeData.dark();

  void changeTheme(bool isDark) {
    if (isDark) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }

    Get.updateLocale(locale.value);
  }

  /// Color
  var appColor = GFColors.INFO;

  colorApp(Color color){
     appColor = color;
     Get.updateLocale(locale.value);
  }

}
