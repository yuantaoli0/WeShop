import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk/router.dart';
import 'package:sdk/xAlertDialog.dart';
import 'controller.dart';
import 'view.dart';

class TerminalTypeRouter extends XBaseRouter {
  @override
  ModalRoute pageRoute(RouteSettings settings) {
    return GetPageRoute(
        settings: settings,
        transition: Transition.fade,
        page: () {
          var args = settings.arguments as Map;
          var ctl = Get.put(TerminalTypeController(args['terminalType']));
          return TabletView(settings.arguments, ctl);
        });
  }

  @override
  dialog(args) async {
    var ctl = Get.put(TerminalTypeController(args['terminalType']));
    var r = await Get.dialog(XAlertDialog(
      TabletView(args, ctl),
      height: 200,
    ));
    Get.delete<TerminalTypeController>();
    return r;
  }
}
