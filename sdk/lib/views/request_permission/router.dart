import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk/router.dart';
import 'controller.dart';
import 'phone_view.dart';
import 'tablet_view.dart';

class RequestPermissionRouter extends XBaseRouter {
  @override
  dialog(dynamic args) async {
    var ctl = Get.put(
      RequestPermissionController(args['permission'], args['message']),
    );
    var r = await Get.dialog(AlertDialog(content: TabletView(ctl)));
    Get.delete<RequestPermissionController>();
    return r;
  }

  @override
  ModalRoute pageRoute(RouteSettings settings) {
    return GetPageRoute(
        settings: settings,
        transition: Transition.fade,
        page: () {
          var args = settings.arguments as Map;
          var ctl = Get.put(RequestPermissionController(args['permission'], args['message']));

          return PhoneView(ctl);
        });
  }
}
