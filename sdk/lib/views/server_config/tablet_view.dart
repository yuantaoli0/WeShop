import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sdk/language.dart';
import 'package:sdk/xView.dart';
import 'package:sdk/xcontroller.dart';
import 'controller.dart';
import 'local.dart';

class TabletView extends XView<ServerConfigController> {
  TabletView(args, ServerConfigController ctl, {super.key}) : super(args, ctl) {
    appLanguge.addLocal(XLocal());
  }

  @override
  Widget build(BuildContext context) {
    //final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanDown: (_) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10.0.w,
                ),
              ],
            ),
            child: Card(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 350),
                width: Get.width / 2,
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                child: Obx(
                  () {
                    return ctl.isLoading.value == true
                        ? const CupertinoActivityIndicator()
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 10.h),
                                child: Text(
                                  'server_config_title'.tr,
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(3.0.w),
                                  ),
                                  border: Border.all(width: 0.5.w, color: Colors.grey),
                                ),
                                padding: EdgeInsets.fromLTRB(10.w, 0, 0, 0),
                                child: TextField(
                                  controller: ctl.hostController,
                                  decoration: InputDecoration(hintText: 'server_config_host'.tr),
                                  autofocus: true,
                                  focusNode: ctl.hostFocus,
                                  textInputAction: TextInputAction.next,
                                  onSubmitted: (v) {
                                    ctl.portFocus.requestFocus();
                                  },
                                ),
                              ),
                              Container(
                                //height: 60.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(3.0.w),
                                  ),
                                  border: Border.all(width: 0.5.w, color: Colors.grey),
                                ),
                                margin: EdgeInsets.fromLTRB(0, 10.h, 0, 0),
                                padding: EdgeInsets.fromLTRB(10.w, 0, 10, 0),
                                child: TextField(
                                  controller: ctl.portController,
                                  focusNode: ctl.portFocus,
                                  textInputAction: TextInputAction.done,
                                  onSubmitted: (v) {
                                    XController.requestFocus(FocusNode());
                                    ctl.setServer();
                                  },
                                  decoration: InputDecoration(hintText: 'server_config_port'.tr),
                                ),
                              ),
                              Divider(
                                height: 20.h,
                              ),
                              SizedBox(
                                width: Get.width,
                                child: ElevatedButton(
                                  onPressed: ctl.setServer,
                                  child: Text(
                                    "server_config_lance".tr,
                                  ),
                                ),
                              )
                            ],
                          );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
