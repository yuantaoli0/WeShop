import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk/router.dart';
import 'controller.dart';
import 'tablet_view.dart';

class TerminalTypeManagerRouter extends XBaseRouter {
  @override
  ModalRoute pageRoute(RouteSettings settings) {
    return GetPageRoute(
        settings: settings,
        transition: Transition.fade,
        page: () {
          var ctl = Get.put(TerminalTypeManagerController());
          return TabletView(settings.arguments, ctl);
        });
  }

  @override
  dialog(args) async {
    var ctl = Get.put(TerminalTypeManagerController());
    var r = await Get.dialog(AlertDialog(
      content: TabletView(args, ctl),
    ));
    Get.delete<TerminalTypeManagerController>();
    return r;
  }
}
