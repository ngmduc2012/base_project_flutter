import 'dart:async';
import 'dart:math';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:developer' as d;

import '../../data/services/localization.dart';

class HomeController extends FullLifeCycleController {
  ///Call HomeController in other model
  static HomeController get to => Get.find();

  String updateErrorMessage = "";

  ///Initial Scroll for SingleChildScrollView, follow: https://stackoverflow.com/a/56220250/10621168
  final ScrollController scrollControllerHome = ScrollController(
    initialScrollOffset: 0.0,
    keepScrollOffset: true,
  );
}
