import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<String?> getDeviceId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor;
  } else if (Platform.isAndroid) {
    const channel = MethodChannel('ai.asklora.app.channelId');
    return await channel.invokeMethod('get_device_id');
  }
  return null;
}

Future<String> getDeviceAgent() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  if (Platform.isAndroid) {
    return '${packageInfo.appName} Android ${packageInfo.version}';
  } else if (Platform.isIOS) {
    return '${packageInfo.appName} iOS ${packageInfo.version}';
  } else {
    return 'unknown';
  }
}
