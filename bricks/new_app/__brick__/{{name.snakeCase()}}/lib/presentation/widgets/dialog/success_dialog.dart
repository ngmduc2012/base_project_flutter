import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import '../../../app/types/colors.dart';
import '../../../app/types/size.dart';
import '../../../app/types/text_style.dart';


class SuccessDialog extends StatelessWidget {
  final String title, descriptions, textButton;

  const SuccessDialog(
      {Key? key,
        required this.title,
        required this.descriptions,
        required this.textButton,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(marginSizeS),
      ),
      elevation: 0,
      // backgroundColor: Colors.transparent,
      child:Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GFListTile(
            avatar: GFAvatar(
                radius: iconSizeS,
                backgroundColor: GFColors.SUCCESS,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.done,
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
            description: Text(descriptions, style: styleCompatibleX(context),),
          ),
          GFListTile(
            title: GFButton(
              textStyle: styleCompatibleX(context),
              color: GFColors.SUCCESS,
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
