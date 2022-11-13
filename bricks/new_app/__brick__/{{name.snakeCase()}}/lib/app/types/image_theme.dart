import 'package:flutter/material.dart';

import '../services/localization.dart';

const String logoImage = "assets/logo/logo.png";

const String avatarImage = "assets/demo_image/avatar.png";

logoHeading(BuildContext context) {
  return (LocalizationService.to.themeMode == ThemeMode.dark)
      ? "assets/logo/logo_heading_dark.png"
      : "assets/logo/logo_heading_light.png";
}

const String vietnameseImage = "assets/lang_image/lang_vi.png";

const String englishImage = "assets/lang_image/lang_en.png";

const String intro_1 = "assets/intro/intro_1.png";
const String intro_2 = "assets/intro/intro_2.png";
const String intro_3 = "assets/intro/intro_3.png";
const String intro_4 = "assets/intro/intro_4.png";
const String intro_5 = "assets/intro/intro_5.png";

