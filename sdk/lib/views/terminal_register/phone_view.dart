import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sdk/language.dart';
import 'package:sdk/xView.dart';
import 'controller.dart';
import 'local.dart';

class PhoneView extends XView<TerminalRegisterController> {
  PhoneView(args, TerminalRegisterController ctl) : super(args, ctl) {
    appLanguge.addLocal(XLocal());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'terminal_register_title'.tr,
          textAlign: TextAlign.center,
          style: scaffoldTitleStyle(),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: ListView(
            //mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10.h),
                height: 100.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'terminal_register_hid'.tr,
                  ),
                  Obx(() => Text(ctl.hid.value)),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(3.0.w),
                  ),
                  border: Border.all(width: 0.5.w, color: Colors.grey),
                ),
                margin: EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.h),
                padding: EdgeInsets.fromLTRB(10.w, 6.h, 10.w, 6.h),
                child: TextField(
                  controller: ctl.nameController,
                  autofocus: true,
                  decoration: InputDecoration.collapsed(
                    hintText: "terminal_register_input_name".tr,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 13.w),
                width: Get.width,
                height: footButtonHeight(),
                child: ElevatedButton(
                  onPressed: ctl.register,
                  child: Text(
                    "terminal_register_ok".tr,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
