import 'package:flutter/material.dart';

class FormHeader extends StatelessWidget {
  final String text;

  const FormHeader({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      height: 52,
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.black87,
              fontSize: 15.5,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
