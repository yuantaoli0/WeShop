import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

abstract class XView<T> extends GetView<T> {
  final dynamic args;
  Widget? get systemMenuDrawer {
    if (args == null) {
      return null;
    } else {
      return args['systemMenu'];
    }
  }

  requestTaskbar() {
    if (Platform.isAndroid) {
      //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
  }

  requestFullScreen() {
    if (Platform.isAndroid) {
      //SystemChrome.setEnabledSystemUIOverlays([]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    }
  }

  bool get isPhone {
    /*MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);

    return data.size.shortestSide < 550;*/
    return min(Get.height, Get.width) < 550;
  }

  T? _ctl;
  XView(this.args, T? ctl, {Key? key}) : super(key: key) {
    _ctl = ctl;
  }

  set ctl(T v) {
    _ctl = v;
  }

  T get ctl {
    return _ctl ?? controller;
  }

  close([result]) {
    Get.back(result: result);
  }

  Color primaryColor() {
    return Get.theme.primaryColor;
  }

  Color secondColor() {
    return Colors.green;
  }

  Color? defaultTextColor() {
    return Get.theme.primaryTextTheme.bodyText1?.color;
  }

  Color? pageTitleColor() {
    return Get.theme.primaryIconTheme.color;
  }

  TextStyle? dialogTitleStyle() {
    return Get.theme.primaryTextTheme.headline6?.copyWith(color: Colors.black, fontSize: titleSize());
  }

  TextStyle? scaffoldTitleStyle() {
    return Get.theme.primaryTextTheme.headline6?.copyWith(fontSize: titleSize());
  }

  TextStyle? primaryButtonTextStyle() {
    return Get.theme.primaryTextTheme.headline6?.copyWith(fontSize: ScreenUtil().setSp(18));
  }

  TextStyle? footButtonTextStyle() {
    return Get.theme.primaryTextTheme.headline6?.copyWith(fontSize: ScreenUtil().setSp(18));
  }

  double footButtonHeight() {
    return 45.h;
  }

  double dialogWidth() {
    return 400.w;
  }

  Color? primaryButtonTextColor() {
    return Get.theme.primaryTextTheme.headline6?.color;
  }

  TextStyle flatButtonStyle() {
    return TextStyle(fontSize: ScreenUtil().setSp(14));
  }

  Color cardColor() {
    return Get.theme.cardColor;
  }

  Color alertColor() {
    return Colors.red;
  }

  Color primaryTextColor() {
    return Colors.black;
    // Get.theme.primaryTextTheme.headline6.color;
  }

  TextStyle captionStyle() {
    return TextStyle(
      color: Colors.grey,
      fontSize: textSize(),
      fontStyle: FontStyle.italic,
    );
  }

  Color captionColor() {
    return Colors.grey;
  }

  double titleSize() {
    return ScreenUtil().setSp(18);
  }

  double subtitleSize() {
    return ScreenUtil().setSp(16);
  }

  double rowTitleSize() {
    return ScreenUtil().setSp(17);
  }

  double rowSubtitleSize() {
    return ScreenUtil().setSp(15);
  }

  double rowHeaderSize() {
    return ScreenUtil().setSp(13);
  }

  double footButtonTextSize() {
    return ScreenUtil().setSp(18);
  }

  double textSize() {
    return ScreenUtil().setSp(12);
  }

  double captionSize() {
    return ScreenUtil().setSp(11);
  }

  Obx obx(WidgetCallback build) {
    WidgetCallback callback = () {
      try {
        return build();
      } catch (e, stack) {
        requestTaskbar();
        return Container(
          child: Text(
            e.toString() + stack.toString(),
            style: TextStyle(color: Colors.red),
            maxLines: 10,
          ),
        );
      }
    };
    var x = new Obx(callback);
    return x;
  }
}
