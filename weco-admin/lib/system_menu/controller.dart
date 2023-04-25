import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sdk/models/user.dart';
import 'package:sdk/xcontroller.dart';

class SystemMenuController extends GetxService {
  final ScrollController controller = ScrollController();
  RxInt selectedIndex = 0.obs;

  static var globalSelectedIndex = 0;

  @override
  void onInit() {
    super.onInit();
  }

  doLogout() async {
    var r = await XController.getConfirm(
        title: 'app_logout_confirm'.tr, content: 'app_logout_confimContent'.tr);

    if (r == true && await User.currentUser?.doLogout() == true) {
      //await Scale.close();
      //exit(0);
      SystemNavigator.pop();
      //exit(0);
    }
  }
}
