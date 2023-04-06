import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk/router.dart';
import 'package:sdk/xAlertDialog.dart';

import 'controller.dart';
import 'view.dart';

class UserTerminalTypesRouter extends XBaseRouter {
  @override
  ModalRoute pageRoute(RouteSettings settings) {
    return GetPageRoute(
        settings: settings,
        transition: Transition.fade,
        page: () {
          var args = settings.arguments as Map;
          var ctl = Get.put(UserTerminalTypesController(args['terminalTypes'], args['selected'] ?? []));
          return View(settings.arguments, ctl);
        });
  }

  @override
  dialog(args) async {
    var ctl = Get.put(UserTerminalTypesController(args['terminalTypes'], args['selected'] ?? []));
    var r = await Get.dialog(XAlertDialog(
      View(args, ctl),
    ));
    Get.delete<UserTerminalTypesController>();
    return r;
  }
}
