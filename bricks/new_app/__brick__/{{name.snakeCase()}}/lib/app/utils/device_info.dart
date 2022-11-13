import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:uuid/uuid.dart';
import 'package:dart_ipify/dart_ipify.dart';

class DeviceInfo {
  static final _instance = DeviceInfo._internal();
  static DeviceInfo get = _instance;

  DeviceInfo._internal();

  final _deviceInfo = DeviceInfoPlugin();
  final _uuid = Uuid();

  Future<String> getDeviceNameAndId() async {
    var defaultName = "Mobile";
    var result = "";
    try {
      if (Platform.isAndroid) {
        var build = await _deviceInfo.androidInfo;
        result =
            "${build.model ?? defaultName}_${build.id ?? _uuid.v4()}";
      } else if (Platform.isIOS) {
        var data = await _deviceInfo.iosInfo;
        result =
            "${data.utsname.machine ?? defaultName}_${data.identifierForVendor ?? _uuid.v4()}";
      }
    } on PlatformException {
      result = defaultName + "_" + _uuid.v4();
      print('Failed to get platform version');
    }
    return Uri.encodeComponent(result);
  }

  Future<String> getDeviceName() async {
    var defaultName = "Mobile";
    try {
      if (Platform.isAndroid) {
        var build = await _deviceInfo.androidInfo;
        return build.model ?? defaultName;
      } else if (Platform.isIOS) {
        var data = await _deviceInfo.iosInfo;
        return data.utsname.machine ?? defaultName;
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
    return "Mobile";
  }

  Future<String> getDeviceId() async {
    try {
      if (Platform.isAndroid) {
        var build = await _deviceInfo.androidInfo;
        return build.id ?? _uuid.v4();
      } else if (Platform.isIOS) {
        var data = await _deviceInfo.iosInfo;
        return data.identifierForVendor ?? _uuid.v4();
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
    return _uuid.v4();
  }

  Future<String> getDeviceIp() async {
    final defaultIP = "192.168.1.1";
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return await Ipify.ipv4();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return await (NetworkInfo().getWifiIP()) ?? defaultIP;
    }
    return defaultIP;
  }
}
