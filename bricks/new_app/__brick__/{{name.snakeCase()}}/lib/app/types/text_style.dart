import 'package:{{name.snakeCase()}}/app/types/colors.dart';
import 'package:{{name.snakeCase()}}/app/types/size.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/colors/gf_color.dart';

import '../services/localization.dart';

const styleXL = TextStyle(
    color: Colors.white,
    fontSize: fontSizeS * 1.36,);

const styleX = TextStyle(
    color: Colors.white,
    fontSize: fontSizeS,);


///Calendar
const styleCalendarHistory = TextStyle(color: Colors.indigo, fontSize: 16.5);

/// Màu chữ mặc định ngược lại với màu theme của thiết bị.
textDark(BuildContext context) {
  return (LocalizationService.to.themeMode == ThemeMode.dark)
      ? GFColors.LIGHT
      : GFColors.FOCUS;
}

styleCompatibleX(BuildContext context) {
  return TextStyle(
      color: (LocalizationService.to.themeMode == ThemeMode.dark)
          ? GFColors.LIGHT
          : GFColors.FOCUS,
      fontSize: fontSizeS,);
}


styleCompatibleXL(BuildContext context) {
  return TextStyle(
      color: (LocalizationService.to.themeMode == ThemeMode.dark)
          ? GFColors.LIGHT
          : GFColors.FOCUS,
      fontSize: fontSizeS*1.36);
}
