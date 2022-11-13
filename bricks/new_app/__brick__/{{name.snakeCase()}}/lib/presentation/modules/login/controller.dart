import 'package:{{name.snakeCase()}}/app/core/values/languages/translations.dart';
import 'package:{{name.snakeCase()}}/app/services/localization.dart';
import 'package:{{name.snakeCase()}}/app/types/colors.dart';
import 'package:{{name.snakeCase()}}/app/types/text_style.dart';
import 'package:{{name.snakeCase()}}/presentation/modules/home/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import 'dart:developer' as d;

import '../../../app/core/routes/routes.dart';

import '../../../app/services/local_storage_get.dart';
import '../../../app/types/key.dart';
import '../../../data/repositories/http.dart';
import '../../widgets/dialog/error_dialog.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();
  var obscureText = true;

  changeObscureText() {
    obscureText = !obscureText;
    update();
  }

  var rememberPassword = false;

  changeRememberPassword(value) {
    rememberPassword = value;
    update();
  }

  final formKey = GlobalKey<FormBuilderState>();

  // final emailFieldKey = GlobalKey<FormBuilderFieldState>();

  Http userRepository;

  LoginController(this.userRepository);

  loading() {
    Get.dialog(
        barrierDismissible: false,
        WillPopScope(
            onWillPop: () async {
              isBackLoading = true;
              return true;
            },
            child: Dialog(
              backgroundColor: AppColors.noColor,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const GFLoader(
                      loaderColorOne: GFColors.INFO,
                      loaderColorTwo: GFColors.SUCCESS,
                      loaderColorThree: GFColors.DANGER,
                      type: GFLoaderType.circle),
                  Text(
                    AppTranslations.loading,
                    style: styleCompatibleX(Get.overlayContext!),
                  ),
                ],
              ),
            )));
  }

  var isBackLoading = false;

  closeLoading() {
    if (!isBackLoading) Get.back();
    isBackLoading = false;
  }

  final LocalStorage _storage = LocalStorage.get;

  login(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        loading();
        update();
        final user = await userRepository.login(
            email: formKey.currentState!.value['email'],
            password: formKey.currentState!.value['password']);
        // this.user = user;
        // HomeController.to.accessToken = user.accessToken!;
        d.log("${user.toJson()}");
        ///Save to storage of device
        await _storage.write(USER_CONTROLLER, user.toJson());
        isLoggedIn = true;
        d.log("${user.toJson()}");
        closeLoading();

        ///Save to storage of device
        // await _storage.write(USER_CONTROLLER, user.toJson());
        // await _storage.write(UUID, user.userId);
        Get.offAllNamed(Routes.HOME);
      } catch (e) {
        isLoggedIn = false;
        closeLoading();
        d.log("${e}");
        Get.dialog(ErrorDialog(
          title: AppTranslations.failure,
          descriptions: Text("$e"),
          textButton: AppTranslations.cancel,
        ));
      }
      update();
    } else {
      if (!formKey.currentState!.fields["email"]!.validate()) {
        emailFocusNode.requestFocus();
      }
      if (!formKey.currentState!.fields["password"]!.validate()) {
        passwordFocusNode.requestFocus();
      }
    }
  }

  bool isLoggedIn = false;

  logout2() {
    isLoggedIn = false;
    Get.offAllNamed(Routes.WELCOME);
  }

  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;

  @override
  void onInit() {
    super.onInit();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }
}
