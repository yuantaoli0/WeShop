import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk/models/terminalType.dart';
import 'package:sdk/views/about/ask_one_time_password/router.dart';
import 'package:sdk/xcontroller.dart';

class TerminalTypeController extends XController {
  Rx<TerminalType?> rxTerminalType = Rx(null);
  TextEditingController limitController = TextEditingController();
  TextEditingController blockTimeoutController = TextEditingController();
  RxBool rxIsReadOnly = true.obs;

  var isSaving = false.obs;
  TerminalTypeController(TerminalType terminalType) {
    rxTerminalType.value = terminalType;
    limitController.text = (terminalType['terminalLimit'] ?? 1).toString();
    blockTimeoutController.text = (terminalType['blockTimeout'] ?? 20).toString();
  }

  unlock() async {
    if (rxIsReadOnly.value == true) {
      var r = await AskOneTimePasswordRouter().gotoName('/askOneTimePassword');
      if (r is Map) {
        rxIsReadOnly.value = !rxIsReadOnly.value;
      }
    }
  }

  setLimit(int quantity) {
    rxTerminalType.value?['terminalLimit'] = quantity;
    rxIsReadOnly.value = true;
  }

  @override
  void onClose() {
    if (result == null) {
      // rxTerminalType.value?.reload();
    }
    super.onClose();
  }

  setTerminalTypeValue(String key, value) {
    rxTerminalType.value?[key] = value;
    rxTerminalType.refresh();
  }

  save() async {
    isSaving.value = true;
    var r = await rxTerminalType.value?.save();
    isSaving.value = false;
    if (r == true) {
      close(true);
    }
  }
}
