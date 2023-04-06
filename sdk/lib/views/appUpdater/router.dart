import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk/router.dart';
import 'controller.dart';
import 'view.dart';

class AppUpdaterRouter extends XBaseRouter {
  @override
  GetPageRoute pageRoute(RouteSettings settings) {
    return GetPageRoute(
        settings: settings,
        transition: Transition.fade,
        page: () {
          var args = settings.arguments as Map;
          var ctl = Get.put(AppUpdaterController(args['newVersion'], args['msg'], args['url']));
          return AppUpdaterView(settings.arguments, ctl);
        });
  }

  @override
  gotoName(String name, {args, isDialog = true}) async {
    return await Get.toNamed(name, arguments: args);
  }

  @override
  dialog(args) async {
    var ctl = Get.put(AppUpdaterController(args['newVersion'], args['msg'], args['url']));
    var r = await Get.dialog(AlertDialog(
      content: AppUpdaterView(args, ctl),
    ));
    Get.delete<AppUpdaterController>();
    return r;
  }
}
