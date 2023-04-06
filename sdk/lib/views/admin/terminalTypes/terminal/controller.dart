import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk/models/terminal.dart';
import 'package:sdk/xcontroller.dart';

class TerminalController extends XController {
  Rx<Terminal?> rxTerminal = Rx(null);
  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  var isSaving = false.obs;
  TerminalController(Terminal terminal) {
    rxTerminal.value = terminal;
  }

  @override
  void onInit() {
    nameController.text = rxTerminal.value?['name'] ?? '';
    super.onInit();
  }

  @override
  void onClose() {
    if (result == null) {
      rxTerminal.value?.reload();
    }
    super.onClose();
  }

  setTerminalValue(String key, value) {
    rxTerminal.value?[key] = value;
    rxTerminal.refresh();
  }

  save() async {
    if (formKey.currentState?.validate() == true) {
      isSaving.value = true;
      var r = await rxTerminal.value?.save();
      isSaving.value = false;
      if (r == true) {
        close(true);
      }
    }
  }

  del() async {
    if (await XController.getConfirm(title: 'terminal_confirm'.tr, content: 'terminal_confirmContent'.tr) == true) {
      isSaving.value = true;
      var r = await rxTerminal.value?.del();
      isSaving.value = false;
      if (r == true) {
        close(false);
      }
    }
  }
}
