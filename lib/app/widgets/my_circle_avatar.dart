import 'dart:convert';
import 'package:flutter/material.dart';

class MyCircleAvatar extends StatelessWidget {
  final String? avatar;
  final double? size;

  const MyCircleAvatar({this.avatar, this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: avatar == null
          ? SizedBox()
          : Image.memory(
              base64Decode(avatar!),
              fit: BoxFit.fill,
              // cache: true,
            ),
    );
  }
}
