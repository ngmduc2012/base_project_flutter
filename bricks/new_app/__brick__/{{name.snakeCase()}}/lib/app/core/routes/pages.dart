
import 'package:{{name.snakeCase()}}/app/core/routes/routes.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';

import '../../../presentation/modules/edit_profile/binding.dart';
import '../../../presentation/modules/edit_profile/screen.dart';
import '../../../presentation/modules/home/binding.dart';
import '../../../presentation/modules/home/screen.dart';
import '../../../presentation/modules/login/binding.dart';
import '../../../presentation/modules/login/screen.dart';
import '../../../presentation/modules/settings/binding.dart';
import '../../../presentation/modules/settings/screen.dart';
import '../../../presentation/modules/sign_up/binding.dart';
import '../../../presentation/modules/sign_up/screen.dart';
import '../../../presentation/modules/welcome/binding.dart';
import '../../../presentation/modules/welcome/screen.dart';

class AppPages {
  static const duration = 500;
  static final pages = [
    GetPage(
      name: Routes.EDIT,
      page: () => const EditProfileScreen(),
      binding: EditProfileBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: duration),
      curve: Curves.fastOutSlowIn,
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => const SettingsScreen(),
      binding: SettingsBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: duration),
      curve: Curves.fastOutSlowIn,
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: duration),
      curve: Curves.fastOutSlowIn,
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: duration),
      curve: Curves.fastOutSlowIn,
    ),
    GetPage(
      name: Routes.SIGN_UP,
      page: () => const SignUpScreen(),
      binding: SignUpBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: duration),
      curve: Curves.fastOutSlowIn,
    ),
    GetPage(
      name: Routes.WELCOME,
      page: () => const WelcomeScreen(),
      binding: WelcomeBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: duration),
      curve: Curves.fastOutSlowIn,
    ),
  ];
}
