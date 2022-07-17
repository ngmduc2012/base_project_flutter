
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/text_style.dart';


class ErrorDialog extends StatelessWidget {
  final String title, text;
  final Widget descriptions;
  final bool? disconnect;

  const ErrorDialog(
      {Key? key,
      required this.title,
      required this.descriptions,
      required this.text,
        this.disconnect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    const defaultSize = 16.0;

    return Container(
      padding: const EdgeInsets.only(
          left: defaultSize + 8,
          top: 2 * defaultSize,
          right: defaultSize,
          bottom: defaultSize),
      margin: const EdgeInsets.only(top: 1.5 * defaultSize),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.cancel,
                size: 32,
                color: Colors.red,
              ),
              const SizedBox(width: defaultSize + 0.8),
              Flexible(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontFamily: "Quicksand",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 1 * defaultSize,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultSize),
            child: descriptions,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: () {
                if(disconnect != null && disconnect == true){
                  // HomeController.to.disConnectTerminal();
                }
                Get.back();
              },
              child: Text(
                text,
                style: styleContentItem.copyWith(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
