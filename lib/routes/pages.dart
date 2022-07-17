
import 'package:base_project/routes/routes.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';

import '../app/module/home/binding.dart';
import '../app/module/home/screen.dart';
import '../app/module/settings/binding.dart';
import '../app/module/settings/screen.dart';
import '../app/module/welcome/binding.dart';
import '../app/module/welcome/screen.dart';


class AppPages {
  static const duration = 500;
  static final pages = [
    GetPage(
      name: Routes.SETTINGS,
      page: () => SettingsScreen(),
      binding: SettingsBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: duration),
      curve: Curves.fastOutSlowIn,
    ),

    GetPage(
      name: Routes.HOME,
      page: () => HomeScreen(),
      binding: HomeBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: duration),
      curve: Curves.fastOutSlowIn,
    ),

    GetPage(
      name: Routes.WELCOME,
      page: () => WelcomeScreen(),
      binding: WelcomeBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: duration),
      curve: Curves.fastOutSlowIn,
    ),
  ];
}
