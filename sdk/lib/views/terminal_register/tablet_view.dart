import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sdk/language.dart';
import 'package:sdk/xView.dart';
import 'controller.dart';
import 'local.dart';

class TabletView extends XView<TerminalRegisterController> {
  TabletView(args, TerminalRegisterController ctl, {super.key}) : super(args, ctl) {
    appLanguge.addLocal(XLocal());
  }

  @override
  Widget build(BuildContext context) {
    var width = Get.width / 2;
    var height = Get.height / 2;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanDown: (_) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        //appBar: AppBar(title: Text('Enregistrer Terminale'),),
        body: SizedBox(
          height: Get.height,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10.0.w,
                  ),
                ],
              ),
              width: width,
              height: height,
              child: Card(
                child: Obx(
                  () {
                    return ctl.isLoading.value == true
                        ? const CupertinoActivityIndicator()
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 10.h),
                                child: Text(
                                  'terminal_register_title'.tr,
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                              Text(
                                'terminal_register_hid'.tr,
                              ),
                              Text(ctl.hid.value),
                              SizedBox(
                                width: width / 2,
                                child: TextField(
                                  controller: ctl.nameController,
                                  autofocus: true,
                                  decoration: InputDecoration(
                                    hintText: "terminal_register_name".tr,
                                  ),
                                  onSubmitted: (value) {
                                    ctl.register();
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: width / 2,
                                  height: 100.h,
                                  child: ElevatedButton(
                                    onPressed: ctl.register,
                                    child: Text(
                                      "terminal_register_ok".tr,
                                    ),
                                  ),
                                ),
                              ),
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
