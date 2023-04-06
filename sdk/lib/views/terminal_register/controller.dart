import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sdk/models/terminal.dart';
import 'package:sdk/models/terminalType.dart';
import 'package:sdk/util/appInfo.dart';
import 'package:sdk/xcontroller.dart';

class TerminalRegisterController extends XController {
  var name = "".obs;
  RxString hid = "".obs;
  var isLoading = false.obs;
  TextEditingController? nameController;
  TerminalRegisterController() {
    hid.value = AppInfo.hid!;
  }

  @override
  void onInit() {
    nameController = TextEditingController(text: name.value);
    super.onInit();
  }

  register() async {
    isLoading.value = true;
    var status = await TerminalType.currentTerminalType?.registerTerminal(name: nameController!.text);
    if (status == TerminalStatus.none) {
      Get.back(result: true);
    }
    isLoading.value = false;
  }
}
