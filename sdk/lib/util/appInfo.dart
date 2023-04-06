import 'dart:io';

//import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:platform_device_id/platform_device_id.dart';

class AppInfo {
  static String? version;
  static String? hid;

  static init() async {
    if (version == null) {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      //String appName = packageInfo.appName;
      //String packageName = packageInfo.packageName;
      version = packageInfo.version;
      //String buildNumber = packageInfo.buildNumber;

    }
    hid ??= await PlatformDeviceId.getDeviceId;
    hid = hid?.trim();
  }
}
