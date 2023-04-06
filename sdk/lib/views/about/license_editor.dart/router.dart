import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk/router.dart';
import 'package:sdk/xAlertDialog.dart';
import 'controller.dart';
import 'phone_view.dart';
import 'tablet_view.dart';

class LisenceEditorRouter extends XBaseRouter {
  @override
  GetPageRoute pageRoute(RouteSettings settings) {
    return GetPageRoute(
        settings: settings,
        transition: Transition.fade,
        page: () {
          var args = settings.arguments as Map;
          var ctl = Get.put(LicenseEditorController(args['code'], args['days'], args['shop']));
          return PhoneView(settings.arguments, ctl);
        });
  }

  /*@override
  gotoName(String name, {args}) async {
    return await dialog(args);
  }*/

  @override
  dialog(args) async {
    var ctl = Get.put(LicenseEditorController(args['code'], args['days'], args['shop']));
    var r = await Get.dialog(XAlertDialog(
      PhoneView(args, ctl),
    ));
    Get.delete<LicenseEditorController>();
    return r;
  }
}
