import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:developer' as d;

import '../../../core/values/colors.dart';
import '../../../core/values/languages/translations.dart';
import '../../../core/values/text_style.dart';
import '../../module/home/controller.dart';

class PermissionDialog extends GetWidget {
  final String? levelPermission;

  const PermissionDialog({this.levelPermission});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.only(
          left: 7,
          top: 2.5 * 7,
          right: 7,
          bottom: 7,
        ),
        margin: const EdgeInsets.only(
          top: 1.5 * 7,
        ),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        height: 250,
        child: Column(
          children: [
            Expanded(
              child: ListTile(
                leading: const Text(""),
                title: Text(
                  AppTranslations.titlePermission,
                  textAlign: TextAlign.center,
                  style: styleTextTitleSetting,
                ),
                trailing: IconButton(
                  iconSize: 32,
                  icon: const Icon(
                    Icons.cancel_outlined,
                    color: AppColors.color4,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ),
            Expanded(
                child: SizedBox(
              width: context.width * 0.7,
              child: Text(
                AppTranslations.detailPermission,
                textAlign: TextAlign.center,
                style: styleTextSetting,
              ),
            )),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                  onPressed: () async {
                    if (levelPermission == "allow") {
                      bool permission =
                          await Permission.camera.request().isGranted;
                      if (permission) {
                        // Get.find<HomeController>().changeCameraPermission(context);
                      }
                    } else {
                      openAppSettings();
                    }
                    Get.back();
                  },
                  child: Text(
                    "${levelPermission!.toUpperCase()}   ",
                    style: styleCalendarHistory,
                  )),
            ),
            // Expanded(
            //     child: Center(
            //   child: TextButton(
            //     onPressed: () async {
            //       if (levelPermission == "allow") {
            //         bool permission =
            //             await Permission.camera.request().isGranted;
            //         if (permission) {
            //           Get.find<HomeController>().changePermission(context);
            //         }
            //       } else {
            //         openAppSettings();
            //       }
            //       Get.back();
            //     },
            //     child: Text(
            //       levelPermission!.toUpperCase(),
            //       // style: textButton,
            //     ),
            //     style: ButtonStyle(
            //         backgroundColor: MaterialStateProperty.all<Color>(color4),
            //         foregroundColor:
            //             MaterialStateProperty.all<Color>(Colors.white)),
            //   ),
            // )),
            const SizedBox(
              height: 18,
            )
          ],
        ),
      ),
    );
  }
}
