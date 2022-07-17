import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/values/colors.dart';
import '../../../core/values/languages/translations.dart';
import '../../../core/values/text_style.dart';
import '../../data/services/localization.dart';
import 'controller.dart';

class SettingsScreen extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(builder: (controller) {
      return Scaffold(
          appBar: AppBar(
            title: ListTile(
              title: Text(
                AppTranslations.settings,
                style: styleTitle,
                textAlign: TextAlign.center,
              ),
              trailing: const Text(""),
            ),
            flexibleSpace: const Image(
              image: AssetImage("assets/images/bg_appbar.png"),
              fit: BoxFit.cover,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    LocalizationService.to.toggleLocale();
                  },
                  child: Row(children: [
                    Text(
                      AppTranslations.language,
                      style: styleTextSetting,
                    ),
                    const Spacer(),
                    Container(
                      width: 31,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 1, color: AppColors.color),
                      ),
                      child: controller.buildFlag(),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ));
    });
  }
}
