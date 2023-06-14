import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sdk/language.dart';
import 'package:sdk/xView.dart';
import 'controller.dart';
import 'local.dart';

import '../tool/theme.dart';

class HomeView extends XView<HomeController> {
  HomeView(args, HomeController controller) : super(args, controller) {
    appLanguge.addLocal(XLocal());
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: backgroudColor,
      body: SafeArea(
        child: Row(
          children: [
            // FutureBuilder<bool>(
            //   future: NfcManager.instance.isAvailable(),
            //   builder: (context, ss) => ss.data != true
            //       ? Center(child: Text('NfcManager.isAvailable(): ${ss.data}'))
            //       : Expanded(
            //           flex: 1,
            //           child: Column(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Expanded(
            //                 flex: 2,
            //                 child: Container(
            //                   margin: EdgeInsets.all(4),
            //                   constraints: BoxConstraints.expand(),
            //                   decoration: BoxDecoration(border: Border.all()),
            //                   child: SingleChildScrollView(
            //                     child: ValueListenableBuilder<dynamic>(
            //                       valueListenable: ctl.result,
            //                       builder: (context, value, _) =>
            //                           Text('${value ?? ''}'),
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //               Expanded(
            //                 flex: 3,
            //                 child: GridView.count(
            //                   padding: EdgeInsets.all(4),
            //                   crossAxisCount: 2,
            //                   childAspectRatio: 4,
            //                   crossAxisSpacing: 4,
            //                   mainAxisSpacing: 4,
            //                   children: [
            //                     ElevatedButton(
            //                       child: Text('Tag Read'),
            //                       onPressed: ctl.tagRead,
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            // ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GetBuilder<HomeController>(
                      init: HomeController(),
                      builder: (controller) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 150.w,
                              height: 150.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: primaryColor,
                                border: Border.all(
                                  color: SecondaryColor,
                                  width: 10.w,
                                ),
                              ),
                              child: Center(
                                child: Obx(() {
                                  return Text(
                                    '${controller.currentTime.value.hour}:${controller.currentTime.value.minute}:${controller.currentTime.value.second}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.sp,
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    Text(
                      'NFC',
                      style: TextStyle(fontSize: 80.sp, color: Colors.white),
                    ),
                    Container(
                      width: 660.w,
                      height: 80.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                        color: primaryColor,
                        border: Border.all(
                          color: SecondaryColor,
                          width: 10.w,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'clock_login'.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              flex: 3,
              child: SvgPicture.asset(
                'assets/icons/nfc_logo.svg', // 替换为您的SVG文件路径
                width: 500.w, // 设置宽度
                height: 500.h, // 设置高度
              ),
            ),
          ],
        ),
      ),
    );
  }
}
