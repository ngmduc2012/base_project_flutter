import 'package:{{name.snakeCase()}}/data/modles/color_select.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'dart:developer' as d;

import '../../../app/core/values/languages/translations.dart';
import '../../../app/services/local_storage_get.dart';
import '../../../app/services/localization.dart';
import '../../../app/types/colors.dart';
import '../../../app/types/image_theme.dart';
import '../../../app/types/key.dart';
import '../../../app/types/size.dart';
import '../../../data/modles/lang_select.dart';
import '../../../data/modles/role_select.dart';

class SettingsController extends GetxController {
  buildFlag() {
    return Obx(() => Center(
      child: () {
        final langCode = LocalizationService.to.locale.value.languageCode;
        if (langCode == 'vi') {
          return const GFImageOverlay(
            colorFilter:
            ColorFilter.mode(AppColors.noColor, BlendMode.colorBurn),
            height: 36,
            width: 36,
            shape: BoxShape.circle,
            image: AssetImage(vietnameseImage),
            boxFit: BoxFit.cover,
          );
        } else {
          return const GFImageOverlay(
            colorFilter:
            ColorFilter.mode(AppColors.noColor, BlendMode.colorBurn),
            height: 36,
            width: 36,
            shape: BoxShape.circle,
            image: AssetImage(englishImage),
            boxFit: BoxFit.cover,
          );
        }
      }(),
    ));
  }

  List<LangSelection> langOptions = [
    LangSelection(
        role: AppTranslations.vietnamese, path: vietnameseImage, code: 'vi'),
    LangSelection(
        role: AppTranslations.english, path: englishImage, code: 'en'),
  ];

  var langOption;

  selectRole(dynamic newValue) {
    if (newValue != null) {
      langOption = newValue as LangSelection;
      LocalizationService.to.toggleLocale(langOption.code);
      d.log("$newValue");
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    langOption = langOptions[0];
    setGroupValue();
  }

  List<ColorSelection> colorOptions = [
    ColorSelection(
      id: 0,
      color: GFColors.DANGER,
    ),
    ColorSelection(
      id: 1,
      color: GFColors.WARNING,
    ),
    ColorSelection(
      id: 2,
      color: GFColors.SUCCESS,
    ),
    ColorSelection(
      id: 3,
      color: GFColors.INFO,
    ),
    ColorSelection(
      id: 4,
      color: GFColors.PRIMARY,
    ),
    ColorSelection(
      id: 5,
      color: GFColors.SECONDARY,
    ),
    ColorSelection(
      id: 6,
      color: GFColors.ALT,
    ),
  ];

  listRadio(context) {
    List<Widget> list = [];
    for (int i = 0; i < colorOptions.length; i++) {
      list.add(
        GFRadio(
          size: iconSizeM,
          activeBorderColor: colorOptions[i].color!,
          value: colorOptions[i].id,
          groupValue: groupValue,
          onChanged: changeColor,
          inactiveIcon: null,
          radioColor: colorOptions[i].color!,
          inactiveBgColor: colorOptions[i].color!,
          inactiveBorderColor: colorCompatible(context),
          activeBgColor: colorCompatible(context),
        ),
      );
    }
    return list;
  }

  int groupValue = 0;

  setGroupValue(){
    for (int i = 0; i < colorOptions.length; i++) {
      if(colorOptions[i].color == LocalizationService.to.appColor){
        groupValue = colorOptions[i].id!;
      }
    }
    update();
  }

  changeColor(value) async {
    groupValue = value;
    LocalizationService.to.colorApp(colorOptions[groupValue].color!);
    await _storage.write(COLOR, value);
    update();
  }

  final LocalStorage _storage = LocalStorage.get;

  changeTheme(value) async {
    if (value != null) {
      LocalizationService.to.changeTheme(value);
      await _storage.write(THEME, value);
    }
  }
}
