import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sdk/models/shop.dart';
import 'package:sdk/models/user.dart';
import 'package:sdk/xcontroller.dart';

class ExpiredInformationController extends XController {
  RxString rxCode = RxString("");
  var shop;
  TextEditingController codeController = TextEditingController();
  @override
  void onInit() {
    User.currentUser?.getCode4OneTimePassword().then((value) {
      Shop().getShopInformation().then((data) {
        shop = data['shop'];
      }).catchError((_) {});
      if (value != null) {
        rxCode.value = value;
      }
    });

    super.onInit();
  }

  @override
  Future<void> accept() async {
    if (codeController.text.trim() != "") {
      var r = await User.currentUser?.checkOneTimePassword(codeController.text);
      if (r is Map && shop != null && shop is Map) {
        var license = shop;
        license["otpCode"] = r['code'];
        license['endDate'] = DateTime.now().add(Duration(days: r['days']));
        var r1 = await Shop().postLisence(license);
        if (r1 == true) {
          SystemNavigator.pop();
        } else {}
      }
    }
  }
}
