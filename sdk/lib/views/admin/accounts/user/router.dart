import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk/router.dart';
import 'package:sdk/xAlertDialog.dart';

import 'controller.dart';
import 'tablet_view.dart';

class AccountRouter extends XBaseRouter {
  @override
  ModalRoute pageRoute(RouteSettings settings) {
    return GetPageRoute(
        settings: settings,
        transition: Transition.fade,
        page: () {
          var args = settings.arguments as Map;
          var ctl = Get.put(AccountControler(args['user']), tag: args['user'] != null ? args['user'].hashCode.toString() : 'user');
          return TabletView(settings.arguments, ctl);
        });
  }

  @override
  dialog(args) async {
    var ctl = Get.put(AccountControler(args['user']));
    var r = await Get.dialog(XAlertDialog(
      TabletView(args, ctl),
    ));
    Get.delete<AccountControler>();
    return r;
  }
}
