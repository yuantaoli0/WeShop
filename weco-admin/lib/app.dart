import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sdk/models/user.dart';
import 'package:sdk/sdkController.dart';
import 'package:sdk/xView.dart';
import 'package:weco_admin/system_menu/menu_view.dart';
import 'package:weco_admin/system_menu/view.dart';
import 'package:weco_admin/theme.dart';
//import 'package:fullscreen/fullscreen.dart';

class AppController extends SDKController {
  @override
  void onInit() async {
    //ScreenUtil.setContext(Get.context!);
    initService('wcwd45e430a5ba2ab1ef').then((r) {
      if (r == true) {
        //if (Platform.isAndroid) {
        //SystemChrome.setEnabledSystemUIOverlays([]);
        //}
        //XView.systemMenuDrawer = getSystemMenu();
        Get.offAllNamed( '/home');
      } else {
        //SystemNavigator.pop();
      }
    });

    super.onInit();
  }

  static Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }
}

// SystemMenuTabletViewer? systemMenu;
// SystemMenuTabletViewer getSystemMenu() {
//   systemMenu ??= SystemMenuTabletViewer({});
//   return systemMenu!;
// }

class AppView extends XView<AppController> {
  AppView(dynamic args) : super(args, null) {
    /*ScreenUtil.init(
      BoxConstraints(minWidth: 300, minHeight: 600, maxWidth: 9999, maxHeight: 9999),
      designSize: isPhone ? Size(360, 672) : Size(1335, 751),
      allowFontScaling: true,
    );*/
    //var fullscreen = new FullScreen();
    //fullscreen.enterFullScreen(FullScreenMode.EMERSIVE_STICKY);
    var ctl = Get.put(AppController());
    this.ctl = ctl;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Center(
        child: SizedBox(
          width: Get.context!.width / 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LinearProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation(Colors.blue),
              ).paddingOnly(bottom: 5.h),
              Obx(() => Text(controller.semantic.value)),
            ],
          ),
        ),
      ),
    );
  }
}
