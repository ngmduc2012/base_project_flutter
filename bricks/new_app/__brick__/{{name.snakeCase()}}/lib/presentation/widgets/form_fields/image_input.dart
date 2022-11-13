import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer' as d;

import '../../../app/core/values/languages/translations.dart';

class ImageInput extends StatefulWidget {
  final Function onSelectedImage;
  final String? avatarBase64;
  final String label;
  final CameraDevice preferredCameraDevice;

  const ImageInput({
    Key? key,
    required this.onSelectedImage,
    this.avatarBase64,
    required this.label,
    this.preferredCameraDevice = CameraDevice.front,
  }) : super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  final picker = ImagePicker();
  File? _image;

  Future _getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(
      source: source,
      preferredCameraDevice: widget.preferredCameraDevice,
    );
    if (pickedFile == null) {
      return;
    }

    ImageCropper imageCropper = ImageCropper();

    final image = await imageCropper.cropImage(
      sourcePath: pickedFile.path,
      maxHeight: 240,
      maxWidth: 240,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
        ),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
      ],
    );
    if (image == null) {
      return;
    }
    widget.onSelectedImage(image.path);
    setState(() {
      _image = File(image.path);
      // UpdateProfileController.to.avatarPath = image.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // d.log("${UserController.to.user!.avatar}");
        _showBottomSheet(context);
      },
      child: Container(
        height: 52,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: Colors.black12, width: 0.5),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.label,
              style: const TextStyle(color: Colors.black87, fontSize: 15.5),
            ),
            _image != null
                ? Image.file(
                    _image!,
                    width: 52,
                    height: 52,
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }

  ListTile _newItem(BuildContext context, IconData iconData, String labelText,
      {Function? onTap}) {
    return ListTile(
      onTap: () {
        Navigator.pop(context);
        if (onTap != null) {
          onTap();
        }
      },
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 18,
            color: Colors.black87,
          ),
        ],
      ),
      title: Text(labelText),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return SafeArea(
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _newItem(
                      context, FontAwesomeIcons.camera, AppTranslations.camera,
                      onTap: () {
                    _getImage(ImageSource.camera);
                  }),
                  _newItem(
                      context, FontAwesomeIcons.images, AppTranslations.library,
                      onTap: () {
                    _getImage(ImageSource.gallery);
                  }),
                  _newItem(
                    context,
                    FontAwesomeIcons.times,
                    AppTranslations.cancel,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
