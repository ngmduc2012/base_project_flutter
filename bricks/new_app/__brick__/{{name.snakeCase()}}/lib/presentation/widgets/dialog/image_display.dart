import 'dart:io';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import '../../../app/types/colors.dart';
import '../../../app/types/size.dart';

class ImageDisplayDialog extends StatelessWidget {
  final String path;
  final double size;
  final bool isAssetImage;

  const ImageDisplayDialog({
    Key? key,
    required this.path,
    required this.size,
    required this.isAssetImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(15),
      // ),
      // elevation: 0,
      backgroundColor: AppColors.noColor,
      child: GFImageOverlay(
        borderRadius: BorderRadius.circular(marginSizeM),
        height: size,
        width: size,
        // child: Center(
        //   child: Text('Light Overlay', style:TextStyle(color: GFColors.LIGHT)),
        // ),
        image: isAssetImage ? AssetImage(path) : Image.file(File(path)).image,
        colorFilter:  const ColorFilter.mode(AppColors.noColor,
            BlendMode.darken),
      ),
    );
  }
}
