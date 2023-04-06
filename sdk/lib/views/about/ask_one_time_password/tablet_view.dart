import 'package:flutter/material.dart';
import 'package:sdk/language.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sdk/util/validator.dart';
import 'package:sdk/xView.dart';
import 'controller.dart';
import 'local.dart';

class TabletView extends XView<AskOneTimePasswordController> {
  TabletView(args, ctl) : super(args, ctl) {
    appLanguge.addLocal(XLocal());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Obx(() => Text(ctl.rxCode.value)),
        TextFormField(
          controller: ctl.codeController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: Validator().notEmpty,
          autofocus: true,
        ),
        Row(
          children: [
            ElevatedButton(
              onPressed: ctl.refuse,
              child: Text('ask_one_time_password_cancel'.tr),
            ),
            ElevatedButton(
              onPressed: ctl.accept,
              child: Text('ask_one_time_password_ok'.tr),
            )
          ],
        )
      ],
    );
  }
}
