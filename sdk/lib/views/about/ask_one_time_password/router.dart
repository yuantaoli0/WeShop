import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk/router.dart';
import 'controller.dart';
import 'tablet_view.dart';

class AskOneTimePasswordRouter extends XBaseRouter {
  @override
  GetPageRoute pageRoute(RouteSettings settings) {
    return GetPageRoute(
        settings: settings,
        transition: Transition.fade,
        page: () {
          var ctl = Get.put(AskOneTimePasswordController());
          return TabletView(settings.arguments, ctl);
        });
  }

  @override
  gotoName(String name, {args, isDialog = true}) async {
    return await dialog(args);
  }

  @override
  dialog(args) async {
    var ctl = Get.put(AskOneTimePasswordController());
    var r = await Get.dialog(AlertDialog(
      content: TabletView(args, ctl),
    ));
    Get.delete<AskOneTimePasswordController>();
    return r;
  }
}
