import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextInput2Controller extends GetxController {
  bool isPasswordField;

  String hintText;
  bool suffixIcon;
  Widget? focusIcon;
  Widget? normalIcon;
  TextInputType keyboardType;
  TextInputAction textInputAction;
  String initialValue;

  late TextEditingController controller;
  late FocusNode focusNode;
  bool hasFocus = false;
  bool showPassword = true;

  CustomTextInput2Controller({
    this.isPasswordField = false,
    this.hintText = "",
    this.keyboardType = TextInputType.text,
    this.suffixIcon = true,
    this.textInputAction = TextInputAction.next,
    this.initialValue = "",
  });

  @override
  void onInit() {
    controller = TextEditingController();
    focusNode = FocusNode();
    super.onInit();
  }

  @override
  onClose() {
    controller.dispose();
    focusNode.dispose();
    super.onClose();
  }

  toggleShowPassword() {
    showPassword = !showPassword;
    update();
  }
}
