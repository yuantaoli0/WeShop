import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sdk/models/shop.dart';
import 'package:sdk/persmission.dart';
import 'package:sdk/views/permission_widget/ink_well_permission.dart';
import 'package:sdk/xView.dart';

import 'expired_information/router.dart';

// ignore: must_be_immutable
class RouteItemView extends XView {
  final String? labelString;
  final String? route;
  final XPermission? permission;
  bool canExpired = true;
  Color? color;
  RxBool rxIsExpanded = false.obs;
  final IconData? icon;
  final List<RouteItemView>? children;
  RouteItemView(this.labelString, this.route, {super.key, this.permission, this.canExpired = true, this.icon, this.color, this.children}) : super({}, null) {
    color ??= primaryColor();
  }

  @override
  Widget build(BuildContext context) {
    var label;
    if (route == null || route == '') {
      label = InkWell(
        onTap: canExpired == true && Shop().isExpired == true
            ? null
            : () async {
                if (children != null && children!.isNotEmpty) {
                  rxIsExpanded.value = !rxIsExpanded.value;
                } else {
                  await Get.toNamed(route!);
                  requestFullScreen();
                }
              },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                icon != null
                    ? Icon(
                        icon,
                        size: 25,
                        color: color,
                      )
                    : Container(),
                Text(labelString!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      //fontWeight: FontWeight.w300,
                      color: color,
                    )).paddingOnly(left: 10.w),
              ],
            ),
            if (children != null && children!.isNotEmpty)
              Obx(
                () => rxIsExpanded.value == false
                    ? Icon(
                        Icons.arrow_drop_down,
                        color: color,
                      )
                    : Icon(
                        Icons.arrow_drop_up,
                        color: color,
                      ),
              ),
          ],
        ).marginSymmetric(horizontal: 8.w, vertical: 10.h),
      );
    } else {
      label = InkWellPermission(
        onTap: canExpired == true && Shop().isExpired == true
            ? () {
                ExpiredInformationRouter().gotoName('/expired_information', args: {});
              }
            : () async {
                if (children != null && children!.isNotEmpty) {
                  rxIsExpanded.value = !rxIsExpanded.value;
                } else {
                  await Get.toNamed(route!, preventDuplicates: false);
                  requestFullScreen();
                }
              },
        permission: permission,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                icon != null
                    ? Icon(
                        icon,
                        size: 25,
                        color: color,
                      )
                    : Container(),
                Text(labelString!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      //fontWeight: FontWeight.w300,
                      color: color,
                    )).paddingOnly(left: 10.w),
              ],
            ),
            if (children != null && children!.isNotEmpty)
              Obx(
                () => rxIsExpanded.value == false
                    ? Icon(
                        Icons.arrow_drop_down,
                        color: color,
                      )
                    : Icon(
                        Icons.arrow_drop_up,
                        color: color,
                      ),
              ),
          ],
        ).marginSymmetric(horizontal: 8.w, vertical: 10.h),
      );
    }
    if (children != null && children!.isNotEmpty) {
      return Column(
        children: [
          label,
          Obx(
            () => rxIsExpanded.value == true
                ? Container(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Column(
                      children: children!,
                    ),
                  )
                : Container(),
          ),
        ],
      );
    }
    return label;
  }
}
