import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SuccessDialog extends StatelessWidget {
  final String title, descriptions, text;
  final bool? disconnect;

  const SuccessDialog(
      {Key? key,
      required this.title,
      required this.descriptions,
      required this.text, this.disconnect})
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
          left: defaultSize,
          top: 2.5 * defaultSize,
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
          Padding(
            padding: const EdgeInsets.only(left: defaultSize),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.check_circle,
                  size: 32,
                  color: Colors.green,
                ),
                const SizedBox(width: defaultSize + 0.8),
                Flexible(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 1.5 * defaultSize,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultSize),
            child: Text(
              descriptions,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 2.2 * defaultSize,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
                onPressed: () {
                  if(disconnect != null && disconnect == true){

                  }
                  Get.back();
                },
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 18, color: Colors.indigo),
                )),
          ),
        ],
      ),
    );
  }
}
