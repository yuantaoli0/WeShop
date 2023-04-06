import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk/router.dart';
import 'controller.dart';
import 'view.dart';

class DepartmentRouter extends XBaseRouter {
  @override
  ModalRoute pageRoute(RouteSettings settings) {
    return GetPageRoute(
        settings: settings,
        transition: Transition.fade,
        page: () {
          var args = settings.arguments as Map;
          var ctl = Get.put(DepartmentController(args['department']));
          return View(settings.arguments, ctl);
        });
  }

  @override
  dialog(args) async {
    var ctl = Get.put(DepartmentController(args['department']));
    var r = await Get.dialog(AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      content: SizedBox(
        width: Get.width / 2,
        child: View(args, ctl),
      ),
    ));
    Get.delete<DepartmentController>();
    return r;
  }
}
