import 'dart:io';

import 'package:{{name.snakeCase()}}/app/core/values/languages/translations.dart';
import 'package:{{name.snakeCase()}}/app/types/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:developer' as d;
import '../../../app/services/localization.dart';
import '../../../app/types/image_theme.dart';
import '../../../data/modles/gender_select.dart';
import '../../../data/modles/role_select.dart';

class EditProfileController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();

  signUp() {
    // Validate returns true if the form is valid, or false otherwise.
    if (formKey.currentState!.validate() ) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      d.log("ok");
    } else {
      if (!formKey.currentState!.fields["userName"]!.validate()) {
        userNameFocusNode.requestFocus();
      }
      if (!formKey.currentState!.fields["email"]!.validate()) {
        emailFocusNode.requestFocus();
      }
      if (!formKey.currentState!.fields["name"]!.validate()) {
        nameFocusNode.requestFocus();
      }
      if (!formKey.currentState!.fields["birthDay"]!.validate()) {
        birthDayFocusNode.requestFocus();
      }
      if (!formKey.currentState!.fields["phoneNumber"]!.validate()) {
        phoneNumberFocusNode.requestFocus();
      }
    }
  }

  var avatar = avatarImage;
  var isAssetImage = true;

  final picker = ImagePicker();

  ImageCropper imageCropper = ImageCropper();
  File? image;

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(
      source: source,
      preferredCameraDevice: CameraDevice.front,
    );
    if (pickedFile == null) {
      return;
    }

    /// Xác định chiều dài, chiều rộng của ảnh: https://stackoverflow.com/a/55428773/10621168
    // var decodedImage = await decodeImageFromList(File(pickedFile.path).readAsBytesSync());

    // if(decodedImage.width != decodedImage.height){
    ImageCropper imageCropper = ImageCropper();

    final image = await imageCropper.cropImage(
      sourcePath: pickedFile.path,
      maxHeight: 350,
      maxWidth: 350,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: AppTranslations.cropper,
          activeControlsWidgetColor:  LocalizationService.to.appColor,
          toolbarColor:  LocalizationService.to.appColor,
          toolbarWidgetColor: AppColors.white,
          initAspectRatio: CropAspectRatioPreset.original,
        ),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
      ],
    );
    if (image == null) {
      return;
    }
    avatar = image.path;
    // }
    // else {
    //   avatar = pickedFile.path;
    // }

    isAssetImage = false;
    update();
  }

  var obscureText = true;

  changeObscureText() {
    obscureText = !obscureText;
    update();
  }

  late FocusNode userNameFocusNode;
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;
  late FocusNode rePasswordFocusNode;
  late FocusNode nameFocusNode;
  late FocusNode birthDayFocusNode;
  late FocusNode phoneNumberFocusNode;

  @override
  void onInit() {
    super.onInit();
    userNameFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    rePasswordFocusNode = FocusNode();
    nameFocusNode = FocusNode();
    birthDayFocusNode = FocusNode();
    phoneNumberFocusNode = FocusNode();

  }

  @override
  void dispose() {
    userNameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    rePasswordFocusNode.dispose();
    nameFocusNode.dispose();
    birthDayFocusNode.dispose();
    phoneNumberFocusNode.dispose();
    super.dispose();
  }

  List<GenderSelection> genderOptions = [
    GenderSelection(gender: AppTranslations.male, icon: Icons.man),
    GenderSelection(gender: AppTranslations.female, icon: Icons.woman),
    GenderSelection(gender: AppTranslations.other, icon: Icons.transgender),
  ];

  List<RoleSelection> roleOptions = [
    RoleSelection(role: AppTranslations.admin, icon: Icons.manage_accounts),
    RoleSelection(role: AppTranslations.number, icon: Icons.account_box),
  ];

}
