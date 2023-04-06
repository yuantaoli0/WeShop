import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk/router.dart';
import 'package:sdk/xAlertDialog.dart';
import 'controller.dart';
import 'view.dart';

class ExpiredInformationRouter extends XBaseRouter {
  @override
  ModalRoute pageRoute(RouteSettings settings) {
    return GetPageRoute(
        settings: settings,
        transition: Transition.fade,
        page: () {
          var ctl = Get.put(ExpiredInformationController());
          return View(settings.arguments, ctl);
        });
  }

  @override
  dialog(args) async {
    var ctl = Get.put(ExpiredInformationController());
    var r = await Get.dialog(XAlertDialog(
      View(args, ctl),
    ));
    Get.delete<ExpiredInformationController>();
    return r;
  }
}
