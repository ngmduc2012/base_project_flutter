import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/colors.dart';
import 'controller.dart';

class WelcomeScreen extends GetView<WelcomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo.jpg",
                // color: Colors.white,
                height: context.width * 0.6,
              ),
              // Text("CIVAMS.EA", style: styleNameApp,),
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.color2,
    );
  }
}
