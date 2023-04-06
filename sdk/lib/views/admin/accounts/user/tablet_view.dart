import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sdk/language.dart';
import 'package:sdk/models/employe.dart';
import 'package:sdk/util/validator.dart';
import 'package:sdk/xView.dart';
import 'package:get/get.dart';
import 'package:sdk/xcontroller.dart';
import 'package:sdk/xpage.dart';
import 'controller.dart';
import 'local.dart';

class TabletView extends XView<AccountControler> {
  TabletView(args, AccountControler ctl) : super(args, ctl) {
    appLanguge.addLocal(XLocal());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanDown: (_) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: XPage(
        appBar: AppBar(
          title: Text(
            'account_title'.tr,
            style: scaffoldTitleStyle()?.copyWith(fontSize: 18),
          ),
          centerTitle: true,
        ),
        body: Container(
            padding: EdgeInsets.all(8.w),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Form(
                          key: ctl.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                //autovalidate: true,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: Validator().notEmpty,
                                style: const TextStyle(fontSize: 14),
                                autocorrect: false,
                                autofocus: ctl.rxUser.value!.isNew,
                                enableSuggestions: false,
                                controller: ctl.loginController,
                                focusNode: ctl.loginFocuse,
                                onEditingComplete: () {
                                  XController.requestFocus(ctl.passwdFocuse);
                                },
                                onChanged: (v) {
                                  ctl.setUserValue('login', v);
                                },
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                                  labelText: 'account_login'.tr,
                                  hintStyle: const TextStyle(fontSize: 14),
                                ),
                              ),
                              TextFormField(
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: Validator().notEmpty,
                                style: const TextStyle(fontSize: 14),
                                autocorrect: false,
                                enableSuggestions: false,
                                controller: ctl.passwdController,
                                focusNode: ctl.passwdFocuse,
                                onEditingComplete: () {
                                  XController.requestFocus(ctl.nameFocuse);
                                },
                                onChanged: (v) {
                                  ctl.setUserValue('passwd', v);
                                },
                                textInputAction: TextInputAction.next,
                                obscureText: true,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                                  labelText: 'account_passwd'.tr,
                                  hintStyle: const TextStyle(fontSize: 14),
                                ),
                              ),
                              TextFormField(
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: Validator().notEmpty,
                                style: const TextStyle(fontSize: 14),
                                autocorrect: false,
                                enableSuggestions: false,
                                controller: ctl.nameController,
                                focusNode: ctl.nameFocuse,
                                onEditingComplete: () {
                                  XController.requestFocus(ctl.telephoneFocuse);
                                },
                                onChanged: (v) {
                                  ctl.setUserValue('name', v);
                                },
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                                  labelText: 'account_name'.tr,
                                  hintStyle: const TextStyle(fontSize: 14),
                                ),
                              ),
                              TextFormField(
                                style: const TextStyle(fontSize: 14),
                                autocorrect: false,
                                enableSuggestions: false,
                                controller: ctl.telephoneController,
                                focusNode: ctl.telephoneFocuse,
                                onEditingComplete: () {
                                  XController.requestFocus(FocusNode());
                                },
                                onChanged: (v) {
                                  ctl.setUserValue('telephone', v);
                                },
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                                  labelText: 'account_telephone'.tr,
                                  hintStyle: const TextStyle(fontSize: 14),
                                ),
                              ),
                              obx(() => Row(
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: DropdownButtonFormField<Employe>(
                                              isExpanded: true,
                                              value: ctl.rxSelectedEmploye.value,
                                              items: ctl.rxEmployes.map<DropdownMenuItem<Employe>>((ep) {
                                                return DropdownMenuItem<Employe>(
                                                  value: ep,
                                                  child: Center(
                                                    child: Text(ep['name']),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (ep) {
                                                ctl.setEmploye(ep);
                                              }),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            ctl.setEmploye(null);
                                          },
                                          icon: const Icon(
                                            Icons.close,
                                            color: Colors.red,
                                          )),
                                    ],
                                  )),
                              // TextFormField(
                              //   style: const TextStyle(fontSize: 14),
                              //   autocorrect: false,
                              //   enableSuggestions: false,
                              //   controller: ctl.cardNumberController,
                              //   focusNode: ctl.cardNumberFocuse,
                              //   onEditingComplete: () {
                              //     XController.requestFocus(FocusNode());
                              //   },
                              //   onChanged: (v) {
                              //     ctl.setUserValue('cardNumber', v);
                              //   },
                              //   textInputAction: TextInputAction.done,
                              //   decoration: InputDecoration(
                              //     contentPadding: const EdgeInsets.symmetric(vertical: 0),
                              //     labelText: 'account_card_number'.tr,
                              //     hintStyle: const TextStyle(fontSize: 14),
                              //   ),
                              // ),
                              InkWell(
                                onTap: ctl.showTerminalTypes,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      obx(
                                        () => Text(
                                          'account_terminal_types'.tr +
                                              (ctl.rxUser.value?['terminalTypes'] == null || ctl.rxUser.value?['terminalTypes'].length == 0
                                                  ? ''
                                                  : '(${ctl.rxUser.value?['terminalTypes'].length.toString()})'),
                                        ),
                                      ),
                                      Icon(
                                        Icons.chevron_right,
                                        size: 25,
                                        color: primaryColor(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 0.h),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'account_active'.tr,
                                    ),
                                    Obx(
                                      () => Switch(
                                        value: ctl.rxUser.value!['active'] ?? true,
                                        activeColor: Colors.blue,
                                        onChanged: (v) {
                                          ctl.setUserValue('active', v);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Obx(
                                  () => ListView.separated(
                                    itemBuilder: (ctx, idx) {
                                      var f = ctl.rxPermissions[idx];
                                      var pi = ctl.rxUser.value!.permissions.indexWhere((p) => p['url'] == f.url);
                                      dynamic up;
                                      if (pi >= 0) {
                                        up = ctl.rxUser.value!.permissions[pi];
                                      }
                                      return Slidable(
                                        //actionPane: SlidableStrechActionPane(),
                                        endActionPane: ActionPane(
                                          extentRatio: 0.75,
                                          motion: const DrawerMotion(),
                                          children: <Widget>[
                                            SlidableAction(
                                              //key: deleteKey,
                                              label: 'account_permission_default'.tr,
                                              backgroundColor: primaryColor(),
                                              icon: AntDesign.home,
                                              onPressed: (ctx) async {
                                                ctl.setDefault(f);
                                              },
                                            )
                                          ],
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.symmetric(vertical: 8.h),
                                          child: InkWell(
                                            onTap: () {
                                              ctl.selectPermission(f);
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    up == null || up['isDefault'] != true
                                                        ? Container()
                                                        : Icon(
                                                            Octicons.dot_fill,
                                                            color: primaryColor(),
                                                          ),
                                                    Text(
                                                      f.displayName,
                                                      style: const TextStyle(fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                                Icon(
                                                  up == null ? Icons.close : (up['canAccess'] == true ? Icons.check_circle : Icons.check_circle_outline),
                                                  color: Colors.blue,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (ctx, idx) {
                                      return Divider(
                                        height: 1.h,
                                      );
                                    },
                                    itemCount: ctl.rxPermissions.length,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Theme.of(context).primaryTextTheme.headline6?.color,
                    ),
                    onPressed: ctl.save,
                    child: Obx(
                      () => ctl.isSaving.value == true
                          ? const CupertinoActivityIndicator()
                          : Text(
                              'account_OK'.tr, //'OK',
                              style: Theme.of(context).primaryTextTheme.headline6?.copyWith(fontSize: 18),
                            ),
                    ),
                  ),
                ),
                ctl.rxUser.value!['isRoot'] == true
                    ? Container()
                    : Container(
                        height: 40,
                        margin: EdgeInsets.only(top: 5.h),
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Theme.of(context).primaryTextTheme.headline6?.color,
                          ),
                          onPressed: ctl.del,
                          child: Obx(
                            () => ctl.isSaving.value == true
                                ? const CupertinoActivityIndicator()
                                : Text(
                                    'account_delete'.tr,
                                    style: Theme.of(context).primaryTextTheme.headline6?.copyWith(fontSize: 18),
                                  ),
                          ),
                        ),
                      ),
              ],
            )),
      ),
    );
  }
}
