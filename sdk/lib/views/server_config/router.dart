import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk/router.dart';

import 'controller.dart';
import 'phone_view.dart';
import 'tablet_view.dart';

class ServerConfigRouter extends XBaseRouter {
  @override
  ModalRoute pageRoute(RouteSettings settings) {
    return GetPageRoute(
        settings: settings,
        transition: Transition.fade,
        page: () {
          var ctl = Get.put(ServerConfigController());
          if (isPhone) {
            return PhoneView(settings.arguments, ctl);
          } else {
            return TabletView(settings.arguments, ctl);
          }
        });
  }

  @override
  dialog(args) async {
    var ctl = Get.put(ServerConfigController());
    var r = await Get.dialog(AlertDialog(
      content: TabletView(args, ctl),
    ));
    Get.delete<ServerConfigController>();
    return r;
  }
}
