import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:sdk/language.dart';
import 'package:sdk/models/user.dart';
import 'package:sdk/util/format.dart';
import 'package:sdk/xView.dart';
import 'controller.dart';
import 'local.dart';

class TabletView extends XView<RequestPermissionController> {
  TabletView(RequestPermissionController ctl, {super.key}) : super({}, ctl) {
    appLanguge.addLocal(XLocal());
  }

  @override
  Widget build(BuildContext context) {
    var windowWidth = 350;
    var btWidth = windowWidth / 4 - 0.5.w;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (ctl.message != null && ctl.message?.isNotEmpty == true)
          SizedBox(
            width: windowWidth.toDouble(),
            child: Text(
              ctl.message!,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
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
          padding: EdgeInsets.fromLTRB(10.w, 0, 0, 0),
          child: DropdownButtonHideUnderline(
            child: Obx(
              () => DropdownButton(
                hint: Text(
                  'request_permission_login'.tr,
                ),
                isExpanded: true,
                value: RequestPermissionController.rxSelectedUser.value,
                items: ctl.rxUsers.map<DropdownMenuItem<User>>(
                  (user) {
                    return DropdownMenuItem<User>(
                      value: user,
                      child: Text(user['login']),
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
          margin: EdgeInsets.fromLTRB(0, 10.h, 0, 0),
          padding: EdgeInsets.fromLTRB(10.w, 0.h, 0.w, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: RawKeyboardListener(
                  onKey: (key) {
                    ctl.physiqueKeyboard(key);
                  },
                  focusNode: ctl.passwordFocus,
                  child: TextField(
                    //readOnly: !isTaped,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'request_permission_passwd'.tr,
                    ),
                    controller: ctl.passwordController,
                    //onSubmitted: (value) {},
                    //style: TextStyle(fontSize: ScreenUtil().setSp(14)),
                    obscureText: true,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.backspace,
                  size: 20,
                ),
                onPressed: () {
                  ctl.input('\b');
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
        ),
        Expanded(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    _buildKeyButton(btWidth, btWidth, char: 'R', code: '\r'),
                    _buildKeyButton(btWidth, btWidth, char: '/', code: '/'),
                    _buildKeyButton(btWidth, btWidth, char: '*', code: '*'),
                    _buildKeyButton(btWidth, btWidth, char: '-', code: '-'),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    _buildKeyButton(btWidth, btWidth, char: '1', code: '1'),
                    _buildKeyButton(btWidth, btWidth, char: '2', code: '2'),
                    _buildKeyButton(btWidth, btWidth, char: '3', code: '3'),
                    _buildKeyButton(btWidth, btWidth, char: '+', code: '+'),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    _buildKeyButton(btWidth, btWidth, char: '4', code: '4'),
                    _buildKeyButton(btWidth, btWidth, char: '5', code: '5'),
                    _buildKeyButton(btWidth, btWidth, char: '6', code: '6'),
                    _buildKeyButton(btWidth, btWidth, char: '%', code: '%'),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  _buildKeyButton(btWidth, btWidth, char: '7', code: '7'),
                                  _buildKeyButton(btWidth, btWidth, char: '8', code: '8'),
                                  _buildKeyButton(btWidth, btWidth, char: '9', code: '9'),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  Container(
                                    width: btWidth * 2,
                                    height: double.infinity,
                                    margin: EdgeInsets.symmetric(
                                      vertical: 0.2.h,
                                      horizontal: 0.2.w,
                                    ),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(0.0),
                                        ),
                                      ),
                                      child: const Text(
                                        '0',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                      onPressed: () {
                                        ctl.input('0');
                                      },
                                    ),
                                  ),
                                  _buildKeyButton(btWidth, btWidth, char: format.decimalSymbol, code: format.decimalSymbol),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      width: btWidth,
                      height: double.infinity,
                      margin: EdgeInsets.symmetric(
                        vertical: 0.2.h,
                        horizontal: 0.2.w,
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                        ),
                        child: const Icon(
                          MaterialCommunityIcons.keyboard_return,
                          size: 20,
                          color: Colors.black,
                        ),
                        onPressed: () async {
                          await ctl.input('\n');
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildKeyButton(double width, double height, {String? char, String? code}) {
    return Container(
      width: width,
      height: double.infinity,
      margin: EdgeInsets.symmetric(
        vertical: 0.2.h,
        horizontal: 0.2.h,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
        ),
        child: Text(
          char!,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        onPressed: () {
          ctl.input(code!);
        },
      ),
    );
  }
}
