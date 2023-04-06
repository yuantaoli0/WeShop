import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:sdk/language.dart';
import 'package:sdk/models/base.dart';
import 'package:sdk/models/terminal.dart';
import 'package:sdk/models/user.dart';
import 'package:sdk/views/about/permissions.dart';
import 'package:sdk/views/admin/accounts/permissions.dart';
import 'package:sdk/views/admin/terminalTypes/permissions.dart';
import 'package:sdk/views/routeItem/view.dart';
import 'package:sdk/xView.dart';
import 'package:sdk/xcontroller.dart';

import 'controller.dart';
import 'local.dart';

class SystemMenuTabletViewer extends XView<SystemMenuController> {
  SystemMenuTabletViewer(args) : super(args, null) {
    appLanguge.addLocal(XLocal());
    var ctl = Get.put(SystemMenuController());
    ctl = ctl;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(User.currentUser?['name']),
                if (User.currentUser?['isRoot'] == true)
                  Text(Terminal.currentTerminal?['name'] + '@' + Base.server),
              ],
            ),
            //推出按钮
            otherAccountsPictures: [
              IconButton(
                icon: const Icon(
                  AntDesign.logout,
                  color: Colors.white,
                  size: 25,
                ),
                onPressed: ctl.doLogout,
              ),
            ],
            accountEmail: Text(
              User.currentUser?['login'],
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            /*currentAccountPicture: CircleAvatar(
              radius: 30.0,
              backgroundColor: Colors.white,
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: Container(
                    margin: EdgeInsets.all(1.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                        image: UserModel.instance.avatarUrl == null ? null : DecorationImage(fit: BoxFit.cover, image: NetworkImage(UserModel.instance.avatarUrl)))),
              ),
            ),*/
            decoration: BoxDecoration(
              color: primaryColor(),
            ),
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: XScrollBehavior(),
              child: ListView(
                controller: ctl.controller,
                children: [
                  RouteItemView(
                    'app_departments'.tr,
                    '/departments',
                    permission: AccountsPermission.instance,
                  ),
                  RouteItemView(
                    'app_employes'.tr,
                    '/employes',
                    permission: AccountsPermission.instance,
                  ),
                  RouteItemView(
                    'app_accounts'.tr,
                    '/accounts',
                    permission: AccountsPermission.instance,
                  ),
                  RouteItemView(
                    'app_terminals'.tr,
                    '/terminals',
                    permission: TerminalTypesPermission.instance,
                  ),
                  RouteItemView(
                    'app_about'.tr,
                    '/about',
                    permission: AboutsPermission.instance,
                    canExpired: false,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
