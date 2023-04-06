import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sdk/language.dart';
import 'package:sdk/xView.dart';
import 'package:sdk/xcontroller.dart';

import 'controller.dart';
import 'local.dart';

class PhoneView extends XView<ServerConfigController> {
  PhoneView(args, ctl) : super(args, ctl) {
    appLanguge.addLocal(XLocal());
  }

  @override
  Widget build(BuildContext context) {
    //final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'server_config_title'.tr,
          textAlign: TextAlign.center,
          style: scaffoldTitleStyle(),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Center(
        child: Obx(
          () {
            return ctl.isLoading.value == true
                ? const CupertinoActivityIndicator()
                : ListView(
                    //mainAxisSize: MainAxisSize.min,
                    //shrinkWrap: true,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10.h),
                        height: 100.h,
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
                          controller: ctl.hostController,
                          focusNode: ctl.hostFocus,
                          textInputAction: TextInputAction.next,
                          onSubmitted: (v) {
                            ctl.portFocus.requestFocus();
                          },
                          decoration: InputDecoration.collapsed(
                            hintText: 'server_config_host'.tr,
                          ),
                          autofocus: true,
                        ),
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
                          controller: ctl.portController,
                          focusNode: ctl.portFocus,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (v) {
                            XController.requestFocus(FocusNode());
                            ctl.setServer();
                          },
                          decoration: InputDecoration.collapsed(
                            hintText: 'server_config_port'.tr,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 13.w),
                        width: Get.width,
                        height: footButtonHeight(),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor(),
                          ),
                          onPressed: ctl.setServer,
                          child: Text(
                            "server_config_lance".tr,
                          ),
                        ),
                      )
                    ],
                  ).paddingSymmetric(horizontal: 8.w);
          },
        ),
      ),
    );
  }
}
