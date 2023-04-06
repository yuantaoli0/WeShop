import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk/models/department.dart';
import 'package:sdk/router.dart';
import 'controller.dart';
import 'view.dart';

class DapartmentRouter extends XBaseRouter {
  @override
  ModalRoute pageRoute(RouteSettings settings) {
    return GetPageRoute(
        settings: settings,
        transition: Transition.noTransition,
        page: () {
          var args = (settings.arguments ?? {}) as Map;
          var ctl = Get.put(DepartmentController());
          return DepartmentView(settings.arguments, ctl);
        });
  }

  @override
  dialog(args) {
    // TODO: implement dialog
    throw UnimplementedError();
  }
}
