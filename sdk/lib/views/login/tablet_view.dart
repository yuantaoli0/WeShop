import 'dart:io';

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

class TabletView extends XView<LoginController> {
  TabletView(args, LoginController ctl) : super(args, ctl) {
    appLanguge.addLocal(XLocal());
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size; // 获取屏幕大小
    // ignore: unused_local_variable
    final double pixelRatio = MediaQuery.of(context).devicePixelRatio; // 获取像素比例
    // ignore: unused_local_variable
    final Orientation orientation =
        MediaQuery.of(context).orientation; // 获取屏幕方向

    return Scaffold(
      // ignore: prefer_const_constructors
      backgroundColor: Color(0xFFF2F3F7),
      body: Row(
        children: [
          Flexible(
            flex: 2,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Positioned(
                  child: Container(
                    width: size.width / 1.9,
                    height: size.width / 1.9,
                    decoration: BoxDecoration(
                      color: Color(0xFF00B0D7),
                      borderRadius: BorderRadius.circular(size.width / 3.8),
                    ),
                  ),
                ),
                Positioned(
                  left: size.width / 3,
                  bottom: size.width / 3,
                  child: Container(
                    width: size.width / 4,
                    height: size.width / 4,
                    decoration: BoxDecoration(
                      color: Color(0xFF0020F2),
                      borderRadius: BorderRadius.circular(size.width / 8),
                    ),
                  ),
                ),
                Positioned(
                  right: size.width / 3,
                  top: size.width / 3,
                  child: Container(
                    width: size.width / 6,
                    height: size.width / 6,
                    decoration: BoxDecoration(
                      color: Color(0xFF0020F2),
                      borderRadius: BorderRadius.circular(size.width / 12),
                    ),
                  ),
                ),
                Positioned(
                  child: Text(
                    'Weshop',
                    style: TextStyle(
                      fontSize: 60.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // ignore: prefer_const_constructors
          SizedBox(
            width: 50,
          ),
          Flexible(
            flex: 1,
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 550),
                width: Get.width / 2,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Obx(
                  () => ctl.isLoading.value
                      ? const CupertinoActivityIndicator()
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // 登录标签
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 250.w),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'login'.tr,
                                  textAlign: TextAlign.end,
                                  // ignore: prefer_const_constructors
                                  style: TextStyle(
                                    fontSize: 10.0,
                                  ),
                                  // style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                //登录文本框
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0.w),
                                    ),
                                    border: Border.all(
                                        width: 0.5.w, color: Colors.grey),
                                  ),
                                  padding: EdgeInsets.fromLTRB(10.w, 0, 0, 0),
                                  child: DropdownButtonHideUnderline(
                                    child: Obx(
                                      () => DropdownButton(
                                        hint: Text(
                                          'login_login'.tr,
                                        ),
                                        isExpanded: true,
                                        value: ctl.rxSelectedUser.value,
                                        items: ctl.rxUsers
                                            .map<DropdownMenuItem<User>>(
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
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0.w),
                                      ),
                                      border: Border.all(
                                          width: 0.5.w, color: Colors.grey),
                                    ),
                                    margin:
                                        EdgeInsets.fromLTRB(0, 10.h, 0, 0.h),
                                    padding:
                                        EdgeInsets.fromLTRB(10.w, 0.h, 0.w, 0),
                                    child: Center(
                                      child: TextField(
                                        focusNode: ctl.passwordFocus,
                                        autofocus: true,
                                        decoration: InputDecoration(
                                          hintText: 'login_passwd'.tr,
                                          border: InputBorder.none,
                                          // contentPadding: EdgeInsets.fromLTRB(10.w, 18.h, 10.w, 13.h),
                                          suffixIcon: InkWell(
                                            child: const Icon(Icons.close),
                                            onTap: () {
                                              ctl.passwordController?.clear();
                                            },
                                          ),
                                        ),
                                        controller: ctl.passwordController,
                                        onSubmitted: (v) async {
                                          await ctl.doLogin();
                                        },
                                        obscureText: true,
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(
                                  height: 20.w,
                                ),
                                // ignore: prefer_const_constructors
                                SizedBox(
                                  height: 60,
                                ),
                                SizedBox(
                                  width: Get.width,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF00B0D7),
                                    ),
                                    child: Text(
                                      "login_ok".tr,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      ctl.doLogin();
                                    },
                                  ),
                                ),
                                const Padding(padding: EdgeInsets.all(5)),
                                SizedBox(
                                  width: Get.width,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF00B0D7),
                                    ),
                                    onPressed: () async {
                                      SystemNavigator.pop();
                                    },
                                    child: Text(
                                      "login_exit".tr,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
