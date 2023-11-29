import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tut_app/domain/model/model.dart';

Future<DeviceInfo> getDeviceInfo() async {
  String name = "unknown";
  String model = "unknown";
  String identifier = "unknown";

  DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      var androidInfo = await _deviceInfoPlugin.androidInfo;
      name = androidInfo.board;
      model = androidInfo.model;
      identifier = androidInfo.id;
    } else if (Platform.isIOS) {
      var iosInfo = await _deviceInfoPlugin.iosInfo;
      name = iosInfo.name;
      model = iosInfo.model;
      identifier = iosInfo.identifierForVendor.toString();
    }
    return DeviceInfo(name, identifier, model);
  } on PlatformException {
    return DeviceInfo(name, identifier, model);
  }
}
