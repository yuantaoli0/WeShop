import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sdk/language.dart';
import 'package:sdk/models/user.dart';
import 'package:sdk/xView.dart';

import 'controller.dart';
import 'local.dart';

class PhoneView extends XView<LoginController> {
  PhoneView(args, ctl) : super(args, ctl) {
    appLanguge.addLocal(XLocal());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => ctl.isLoading.value
              ? const CupertinoActivityIndicator()
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10.w),
                        child: Text(
                          'login_title'.tr,
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
                        margin: EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.h),
                        padding: EdgeInsets.fromLTRB(10.w, 0.h, 10.w, 0.h),
                        child: DropdownButtonHideUnderline(
                          child: Obx(
                            () => DropdownButton(
                              hint: Text(
                                'login_login'.tr,
                              ),
                              isExpanded: true,
                              value: ctl.rxSelectedUser.value,
                              items: ctl.rxUsers.map<DropdownMenuItem<User>>(
                                (user) {
                                  return DropdownMenuItem<User>(
                                    value: user,
                                    child: Center(
                                      child: Text(user['login']),
                                    ),
                                  );
                                },
                              ).toList(),
                              onChanged: (User? user) {
                                ctl.selectUser(user);
                              },
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(3.0.w),
                          ),
                          border: Border.all(width: 0.5.w, color: Colors.grey),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 13.w, vertical: 3.h),
                        padding: EdgeInsets.fromLTRB(10.w, 0.h, 10.w, 0.h),
                        child: Center(
                          child: TextField(
                            focusNode: ctl.passwordFocus,
                            autofocus: true,
                            decoration: InputDecoration(
                              hintText: 'login_passwd'.tr,
                              border: InputBorder.none,
                              /*suffix: IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  ctl.passwordController.clear();
                                },
                              ),*/
                            ),
                            controller: ctl.passwordController,
                            onSubmitted: (v) async {
                              await ctl.doLogin();
                            },
                            obscureText: true,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.h),
                        width: Get.width,
                        height: footButtonHeight(),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor(),
                          ),
                          onPressed: () {
                            ctl.doLogin();
                          },
                          child: Text(
                            "login_ok".tr,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 13.w),
                        width: Get.width,
                        height: footButtonHeight(),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: alertColor(),
                          ),
                          onPressed: () async {
                            SystemNavigator.pop();
                          },
                          child: Text(
                            "login_exit".tr,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
