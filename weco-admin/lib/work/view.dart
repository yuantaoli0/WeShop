import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sdk/language.dart';
import 'package:sdk/xView.dart';
import 'controller.dart';
import 'local.dart';

import '../tool/theme.dart';

class WorkView extends XView<WorkController> {
  WorkView(args, WorkController controller) : super(args, controller) {
    appLanguge.addLocal(XLocal());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroudColor,
      body: Stack(
        fit: StackFit.loose,
        children: [
          Center(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 30.h),
                    child: Text(
                      "Clocking in to work\nsuccessfully\nHave a great day! Jonh",
                      style: TextStyle(fontSize: 80.sp, color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 300.h, // set the height
                    width: 300.w, // set the width
                    child: const Image(
                      image: AssetImage('assets/images/smile.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
