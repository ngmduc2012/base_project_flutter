import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import '../../../app/types/colors.dart';
import '../../../app/core/values/languages/translations.dart';
import '../../../app/types/size.dart';
import '../../../app/types/text_style.dart';
import '../../../app/services/localization.dart';
import 'controller.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(builder: (controller) {
      return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              color: LocalizationService.to.appColor,
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.home,
                size: iconSizeM,
              ),
            ),
            title: Text(
              AppTranslations.settings,
              style: TextStyle(color: textDark(context)),
            ),
            shadowColor: AppColors.noColor,
            backgroundColor: AppColors.noColor,
          ),
          body: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),

            /// Bug: Vertical viewport was given unbounded height
            /// The following: https://stackoverflow.com/a/54587532/10621168
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: marginSizeM),
                child: Column(
                  children: [
                    SizedBox(
                      height: context.height * 0.02,
                    ),

                    /// *Lựa chọn không theo form
                    Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.all(marginSizeM),
                      child: DropdownButtonHideUnderline(
                        child: GFDropdown(
                          // padding: const EdgeInsets.all(15),
                          borderRadius: BorderRadius.circular(marginSizeM),
                          border: BorderSide(
                              color: LocalizationService.to.appColor, width: 1),
                          dropdownButtonColor: AppColors.noColor,
                          value: controller.langOption,
                          onChanged: controller.selectRole,
                          items: controller.langOptions
                              .map((value) => DropdownMenuItem(
                            value: value,
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20),
                                child: Row(
                                  children: [
                                    GFImageOverlay(
                                      colorFilter:
                                      const ColorFilter.mode(
                                          AppColors.noColor,
                                          BlendMode.colorBurn),
                                      height: 36,
                                      width: 36,
                                      shape: BoxShape.circle,
                                      image: AssetImage(value.path!),
                                      boxFit: BoxFit.cover,
                                    ),
                                    Padding(
                                        padding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          value.role!,
                                          style: const TextStyle(
                                              fontSize: fontSizeS,
                                              color: Colors.grey),
                                        )),
                                  ],
                                )),
                          ))
                              .toList(),
                        ),
                      ),
                    ),

                    Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(
                          horizontal: marginSizeM, vertical: marginSizeM),
                      child: GFBorder(
                        radius: const Radius.circular(marginSizeM),
                        color: LocalizationService.to.appColor,
                        dashedLine: const [2, 0],
                        type: GFBorderType.rRect,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: controller.listRadio(context),
                        ),
                      ),
                    ),

                    Container(
                      height: 80,
                      margin: const EdgeInsets.symmetric(
                          horizontal: marginSizeM, vertical: marginSizeM),
                      child: GFBorder(
                        radius: const Radius.circular(marginSizeM),
                        color: LocalizationService.to.appColor,
                        dashedLine: const [2, 0],
                        type: GFBorderType.rRect,
                        child: GFListTile(
                            padding: const EdgeInsets.all(0),
                            margin: const EdgeInsets.all(0),
                            avatar: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(
                                      left: 15, right: marginSizeM),
                                  child: Icon(
                                    Icons.color_lens,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  AppTranslations.darkMode,
                                  style: styleCompatibleX(context),
                                ),
                              ],
                            ),
                            icon: GFToggle(
                              duration: const Duration(milliseconds: 108),
                              enabledTrackColor:
                              LocalizationService.to.appColor,
                              onChanged: (val) {
                                controller.changeTheme(val);
                              },
                              value: LocalizationService.to.themeMode ==
                                  ThemeMode.dark,
                              type: GFToggleType.ios,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: context.height * 0.5,
              )
            ],
          ));
    });
  }
}
