import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk/models/base.dart';
import 'package:sdk/xcontroller.dart';

class ServerConfigController extends XController {
  TextEditingController? hostController;
  TextEditingController? portController;
  FocusNode hostFocus = FocusNode();
  FocusNode portFocus = FocusNode();
  var isLoading = false.obs;
  @override
  void onInit() {
    hostController = TextEditingController();
    portController = TextEditingController();
    hostController?.text = Base.host.replaceFirst('http://', '');
    portController?.text = Base.port;
    super.onInit();
  }

  setServer() async {
    isLoading.value = true;
    if (await NetBase.setServer(hostController!.text, portController!.text) == true) {
      Get.back(result: true);
    } else {
      //var loading = true.obs;
      //XController.showLoading(loading);
      //XController.showMessage('Le serveur n\'existe pas');
      //await Future.delayed(Duration(seconds: 2));
      //loading.value = false;
    }
    isLoading.value = false;
  }
}
