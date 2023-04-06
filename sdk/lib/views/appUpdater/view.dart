import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sdk/xView.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'controller.dart';

class AppUpdaterView extends XView<AppUpdaterController> {
  AppUpdaterView(args, ctl, {super.key}) : super(args, ctl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Ionicons.md_rocket,
              color: Colors.blue,
              size: 150.w,
            ),
            Text(ctl.newVersion!, style: TextStyle(fontSize: rowTitleSize())),
            Text(
              ctl.msg!,
              style: TextStyle(fontSize: rowSubtitleSize()),
            ),
            Container(
              width: 500.w,
              margin: EdgeInsets.only(top: 20.h),
              child: Obx(
                () => LinearProgressIndicator(
                  value: ctl.rxProgressValue.value,
                  backgroundColor: Colors.grey[200],
                  valueColor: const AlwaysStoppedAnimation(Colors.blue),
                ),
              ),
            ),
            Text(
              ctl.rxUpdateStatus.value,
              style: TextStyle(fontSize: rowSubtitleSize()),
            )
          ],
        ),
      ),
    );
  }
}
