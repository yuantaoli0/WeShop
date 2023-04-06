import 'package:flutter/material.dart';
import 'package:sdk/util/validator.dart';
import 'package:sdk/views/first_start/controller.dart';
import 'package:sdk/xView.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RootUserView extends XView<FirstStartController> {
  RootUserView(ctl, {super.key}) : super({}, ctl) {
    ctl.nameController.text = ctl.rxUser['name'] ?? '';
    ctl.loginController.text = ctl.rxUser['login'] ?? '';
    ctl.passwdController.text = ctl.rxUser['passwd'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: Get.width / 2,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10.0.w,
            ),
          ],
        ),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: ctl.userFormKey,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      TextFormField(
                        validator: Validator().notEmpty,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        //style: TextStyle(fontSize: ScreenUtil().setSp(16)),
                        autocorrect: false,
                        textInputAction: TextInputAction.next,
                        controller: ctl.nameController,
                        autofocus: ctl.rxUser['name'] == null,
                        focusNode: ctl.nameFocus,
                        onChanged: (value) {
                          ctl.setRootUserValue('name', value);
                        },
                        onEditingComplete: () {
                          ctl.loginFocus.requestFocus();
                          //FocusScope.of(context).requestFocus(fnLogin);
                        },
                        enableSuggestions: false,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 0),
                          labelText: 'first_start_user_name'.tr,
                          //labelStyle: TextStyle(fontSize: rowSubtitleSize()),
                        ),
                      ),
                      TextFormField(
                        validator: Validator().notEmpty,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        //style: TextStyle(fontSize: rowSubtitleSize()),
                        autocorrect: false,
                        textInputAction: TextInputAction.next,
                        enableSuggestions: false,
                        controller: ctl.loginController,
                        focusNode: ctl.loginFocus,
                        onChanged: (value) {
                          ctl.setRootUserValue('login', value);
                        },
                        onEditingComplete: () {
                          ctl.passwdFocus.requestFocus();
                          //FocusScope.of(context).requestFocus(fnPasswd);
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 0),
                          labelText: 'first_start_login'.tr,
                          //labelStyle: TextStyle(fontSize: rowSubtitleSize()),
                        ),
                      ),
                      TextFormField(
                        validator: Validator().notEmpty,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        //style: TextStyle(fontSize: rowSubtitleSize()),
                        autocorrect: false,
                        textInputAction: TextInputAction.done,
                        enableSuggestions: false,
                        obscureText: true,
                        controller: ctl.passwdController,
                        focusNode: ctl.passwdFocus,
                        onChanged: (value) {
                          ctl.setRootUserValue('passwd', value);
                        },
                        onEditingComplete: ctl.validRootUser,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 0),
                          labelText: 'first_start_password'.tr,
                          //labelStyle: TextStyle(fontSize: rowSubtitleSize()),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.all(8)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: ctl.validRootUser,
                      child: Text('first_start_next'.tr),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
