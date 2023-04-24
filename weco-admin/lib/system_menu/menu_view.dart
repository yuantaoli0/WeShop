// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sdk/xView.dart';
import 'package:weco_admin/system_menu/controller.dart';
import 'package:weco_admin/system_menu/view.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideMenu extends XView<SystemMenuController> {
  SideMenu() : super(null, null) {
    var ctl = Get.put(SystemMenuController());
    this.ctl = ctl;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFF252525),
      //这里让菜单可滑动
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(child: Image.asset("assets/images/weshop-logo.jpeg")),
            _buildDrawerListTile(
                title: "首页",
                svgSrc: "assets/icons/home.svg",
                onPress: () {
                  Get.toNamed('/home');
                  ctl.selectedIndex.value = 0;
                },
                index: 0),
            _buildDrawerListTile(
                title: "时间计划表",
                svgSrc: "assets/icons/schedule.svg",
                onPress: () {
                  Get.toNamed('/schedule');
                  ctl.selectedIndex.value = 1;
                },
                index: 1),
            _buildDrawerListTile(
                title: "部门管理",
                svgSrc: "assets/icons/department.svg",
                onPress: () {
                  ctl.selectedIndex.value = 2;
                  Get.offNamed('/departments');
                },
                index: 2),
            // _buildDrawerListTile(
            //     title: "岗位管理",
            //     svgSrc: "assets/icons/job_management.svg",
            //     onPress: () {
            //       // Get.toNamed('/jobmanagement');
            //     }),
            _buildDrawerListTile(
                title: "合同管理",
                svgSrc: "assets/icons/contract_management.svg",
                onPress: () {
                  Get.toNamed('/contractmanagement');
                  ctl.selectedIndex.value = 3;
                },
                index: 3),
            // _buildDrawerListTile(
            //     title: "消息",
            //     svgSrc: "assets/icons/message.svg",
            //     onPress: () {}),
            // _buildDrawerListTile(
            //     title: "团队成员",
            //     svgSrc: "assets/icons/member_teams.svg",
            //     onPress: () {}),
            _buildDrawerListTile(
                title: "设置",
                svgSrc: "assets/icons/setting.svg",
                onPress: () {
                  ctl.selectedIndex.value = 4;
                },
                index: 4),
          ],
        ),
      ),
    );
  }

  Padding _buildDrawerListTile(
      {required String title,
      required String svgSrc,
      required onPress,
      required int index}) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: ListTile(
        onTap: onPress,
        horizontalTitleGap: 0.0,
        // ignore: prefer_const_constructors
        title: Obx(() => Text(
              title,
              style: TextStyle(
                  color: ctl.selectedIndex.value == index
                      ? Colors.orange
                      : Colors.white),
            )),
        leading: Obx(() => SvgPicture.asset(
              svgSrc,
              color: ctl.selectedIndex.value == index
                  ? Colors.orange
                  : Colors.white,
              height: 20,
            )),
      ),
    );
  }
}
