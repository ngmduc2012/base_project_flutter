import 'package:{{name.snakeCase()}}/app/types/colors.dart';
import 'package:{{name.snakeCase()}}/app/types/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import '../../../app/types/text_style.dart';

class ErrorDialog extends StatelessWidget {
  final String title, textButton;
  final Widget descriptions;

  const ErrorDialog({
    Key? key,
    required this.title,
    required this.descriptions,
    required this.textButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(marginSizeS),
      ),
      elevation: 0,
      // backgroundColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GFListTile(
            avatar: GFAvatar(
                radius: iconSizeS,
                backgroundColor: GFColors.DANGER,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.error,
                    color: AppColors.white,
                    size: iconSizeS,
                  ),
                )),
            title: Text(
              title,
              style: styleCompatibleXL(context),
            ),
          ),
          GFListTile(
            description: descriptions,
          ),
          GFListTile(
            title: GFButton(
              textStyle: styleCompatibleX(context),
              color: GFColors.DANGER,
              fullWidthButton: true,
              onPressed: () {
                Get.back();
              },
              text: textButton,
              // icon: const Icon(Icons.cancel,
              //     size: iconSizeM,
              //     color: GFColors.DANGER),
              // type: GFButtonType.outline2x,
              type: GFButtonType.outline2x,
            ),
          ),
        ],
      ),
    );
  }
}
