import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk/router.dart';

import 'controller.dart';
import 'view/index.dart';

class FirstStartRouter extends XBaseRouter {
  @override
  ModalRoute pageRoute(RouteSettings settings) {
    return GetPageRoute(
        settings: settings,
        transition: Transition.fade,
        page: () {
          var ctl = Get.put(FirstStartController());

          return FirstStartView(settings.arguments, ctl);
        });
  }

  @override
  gotoName(String name, {args, isDialog = true}) async {
    return await Get.toNamed(name, arguments: args);
  }

  @override
  dialog(args) async {
    var ctl = Get.put(FirstStartController());
    var r = await Get.dialog(AlertDialog(
      content: FirstStartView(args, ctl),
    ));
    Get.delete<FirstStartController>();
    return r;
  }
}
