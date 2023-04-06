import 'package:flutter/material.dart';
import 'package:sdk/language.dart';
import 'package:sdk/util/validator.dart';
import 'package:sdk/xView.dart';
import 'package:sdk/xpage.dart';
import 'package:get/get.dart';
import 'controller.dart';
import 'local.dart';

class View extends XView<ExpiredInformationController> {
  View(args, ExpiredInformationController ctl) : super(args, ctl) {
    appLanguge.addLocal(XLocal());
  }

  @override
  Widget build(BuildContext context) {
    return XPage(
      appBar: AppBar(
        title: Text('expired_information_title'.tr),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: Column(
              children: [
                Text('expired_information_content'.tr),
                obx(() => Text(
                      ctl.rxCode.value,
                      style: TextStyle(color: alertColor()),
                    )),
                TextFormField(
                  controller: ctl.codeController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: Validator().notEmpty,
                  autofocus: true,
                ),
              ],
            ),
          ),
          Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: primaryColor(),
                ),
                onPressed: ctl.accept,
                child: Container(
                  height: footButtonHeight(),
                  width: Get.width,
                  child: Center(
                    child: Text('expired_information_OK'.tr),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: alertColor(),
                ),
                onPressed: ctl.close,
                child: SizedBox(
                  height: footButtonHeight(),
                  width: Get.width,
                  child: Center(
                    child: Text('expired_information_cancel'.tr),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
