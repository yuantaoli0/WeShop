import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk/router.dart';
import 'controller.dart';
import 'view.dart';

class DepartmentManagerRouter extends XBaseRouter {
  @override
  ModalRoute pageRoute(RouteSettings settings) {
    return GetPageRoute(
        settings: settings,
        transition: Transition.fade,
        page: () {
          var ctl = Get.put(DepartmentManagerController());
          return View(settings.arguments, ctl);
        });
  }

  @override
  dialog(args) async {
    var ctl = Get.put(DepartmentManagerController());
    var r = await Get.dialog(AlertDialog(
      content: View(args, ctl),
    ));
    Get.delete<DepartmentManagerController>();
    return r;
  }
}
