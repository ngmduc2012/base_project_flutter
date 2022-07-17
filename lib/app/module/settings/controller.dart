import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as d;

import '../../data/services/localization.dart';

class SettingsController extends GetxController {
  buildFlag() {
    return Obx(() => Center(
      child: () {
        final langCode = LocalizationService.to.locale.value.languageCode;
        if (langCode == 'vi') {
          return const CircleAvatar(
            backgroundImage: AssetImage('assets/images/lang_vi.png'),
            radius: 18,
            backgroundColor: Colors.transparent,
          );
        } else {
          return const CircleAvatar(
            backgroundImage: AssetImage('assets/images/lang_en.png'),
            radius: 18,
            backgroundColor: Colors.transparent,
          );
        }
      }(),
    ));
  }
}
