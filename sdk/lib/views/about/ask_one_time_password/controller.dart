import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk/models/user.dart';
import 'package:sdk/xcontroller.dart';

class AskOneTimePasswordController extends XController {
  RxString rxCode = RxString("");
  TextEditingController codeController = TextEditingController();

  @override
  void onInit() {
    User.currentUser?.getCode4OneTimePassword().then((value) {
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
      if (r != null) {
        close(r);
      }
    }
  }
}
