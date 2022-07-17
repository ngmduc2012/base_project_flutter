import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/keys.dart';
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

  toggleLocale() {
    String langCode = "en";
    if (locale.value.languageCode != "vi") {
      langCode = "vi";
    }
    changeLocale(langCode);
  }

  void changeLocale(String langCode) {
    locale.value = getLocaleFromLanguage(langCode: langCode);
    localStorage.write(LocalStorageKeys.LANG_CODE, locale.value.languageCode);
    Get.updateLocale(locale.value);
  }

}
