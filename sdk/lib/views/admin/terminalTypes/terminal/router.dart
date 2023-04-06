import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk/router.dart';
import 'package:sdk/xAlertDialog.dart';

import 'controller.dart';
import 'tablet_view.dart';

class TerminalRouter extends XBaseRouter {
  @override
  ModalRoute pageRoute(RouteSettings settings) {
    return GetPageRoute(
        settings: settings,
        transition: Transition.fade,
        page: () {
          var args = settings.arguments as Map;
          var ctl = Get.put(TerminalController(args['terminal']));
          return TabletView(settings.arguments, ctl);
        });
  }

  @override
  dialog(args) async {
    var ctl = Get.put(TerminalController(args['terminal']));
    var r = await Get.dialog(XAlertDialog(
      TabletView(args, ctl),
    ));
    Get.delete<TerminalController>();
    return r;
  }
}
