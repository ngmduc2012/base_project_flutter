
import 'package:{{name.snakeCase()}}/app/services/localization.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/colors/gf_color.dart';

abstract class AppColors {
  // static const appColor = GFColors.INFO;
  static const white = GFColors.WHITE;
  static const light = GFColors.LIGHT;
  static const dark = GFColors.DARK;
  static const noColor = GFColors.TRANSPARENT;

}

/// Màu thuận theo theme sáng hoặc tối của thiết bị
colorCompatible(BuildContext context){
  return (LocalizationService.to.themeMode == ThemeMode.dark) ?  GFColors.DARK : GFColors.WHITE;
}

/// Màu ngược với theme sáng hoặc tối của thiết bị (dùng để hiển thị icon, chữ,... )
colorIncompatible(BuildContext context){
  return (LocalizationService.to.themeMode == ThemeMode.dark) ?  GFColors.WHITE : GFColors.DARK;
}


colorIcon(BuildContext context){
  return (LocalizationService.to.themeMode == ThemeMode.dark) ?  GFColors.LIGHT : LocalizationService.to.appColor;
}


