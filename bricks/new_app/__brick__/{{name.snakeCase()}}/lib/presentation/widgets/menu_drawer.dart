import 'package:getwidget/getwidget.dart';
import 'package:{{name.snakeCase()}}/presentation/modules/home/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:developer' as d;

import '../../app/core/routes/routes.dart';
import '../../app/services/localization.dart';
import '../../app/types/colors.dart';
import '../../app/core/values/languages/translations.dart';
import '../../app/types/image_theme.dart';
import '../../app/types/size.dart';
import '../../app/types/text_style.dart';

class MenuDrawer extends GetView<HomeController> {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GFDrawer(
      elevation: 0,
      child: ListView(
        children: [
          GFDrawerHeader(
            // centerAlign: true,
            margin: const EdgeInsets.only(bottom: marginSizeS),
            decoration: const BoxDecoration(
              color: AppColors.noColor,
            ),
            // centerAlign: true,
            closeButton: const SizedBox(),
            currentAccountPicture:  GFAvatar(
                size: GFSize.SMALL,
                // radius: 80.0,
                backgroundImage: controller.user.avatar != null ? Image.memory(
                  controller.user.avatar!,
                ).image : null),
            otherAccountsPictures: <Widget>[
              // GFAvatar(
              //   backgroundImage:AssetImage(
              //       avatarImage,
              //     ),
              //   ),

              GFAvatar(
                  backgroundColor:  LocalizationService.to.appColor,
                  child: IconButton(
                    onPressed: controller.logout,
                    icon: const Icon(
                      Icons.logout,
                      color: AppColors.white,
                      size: iconSizeS,
                    ),
                  )),
            ],
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                const SizedBox(
                  height: marginSizeM,
                ),
                Text(controller.user.name ?? "", style: styleCompatibleXL(context)),
                Text(controller.user.email ?? "",
                    style: styleCompatibleX(context)),
              ],
            ),
          ),
          Divider(
            color: colorIncompatible(context),
          ),
          GFListTile(
            padding: const EdgeInsets.only(left: marginSizeM * 3),
            margin: const EdgeInsets.symmetric(
                vertical: marginSizeM, horizontal: marginSizeM),
            title: Padding(
              padding: const EdgeInsets.only(left: marginSizeM * 2),
              child: Text(
                AppTranslations.settings,
                style: styleCompatibleXL(context),
              ),
            ),
            avatar: Icon(
              Icons.settings,
              color: colorIcon(context),
              size: iconSizeM,
            ),
            onTap: () async {
              Get.offAndToNamed(Routes.SETTINGS);
            },
          ),
        ],
      ),
    );
    // });
  }
}
