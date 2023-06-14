import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sdk/language.dart';
import 'package:sdk/xView.dart';
import 'controller.dart';
import 'local.dart';

import '../tool/theme.dart';

class OptionView extends XView<OptionController> {
  OptionView(args, OptionController controller) : super(args, controller) {
    appLanguge.addLocal(XLocal());
  }

  @override
  Widget build(BuildContext context) {
    final List<List<Widget>> cards = List.generate(
      8,
      (index) => Card(
        child: Obx(() => ElevatedButton(
              onPressed: () {
                ctl.selectedIndex.value = index;
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ctl.selectedIndex.value == index
                    ? Color(0xFF3F22F2)
                    : primaryColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Icon(
                      ctl.buttonIcons[index],
                      color: Colors.black,
                      size: 35.sp,
                    ),
                  ),
                  Container(
                    width: 85.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30), // 设置圆角为20
                    ),
                    child: Center(
                      child: Text(
                        ctl.buttonTexts[index].tr,
                        style: TextStyle(color: Colors.white, fontSize: 15.sp),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    ).chunked(4).toList();

    return Scaffold(
      backgroundColor: backgroudColor,
      body: Stack(
        fit: StackFit.loose,
        children: [
          Center(
            child: Opacity(
              opacity: 0.1, // 透明度为10%
              child: Image.asset(
                'assets/images/weshop_logo.png',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 50.h),
            child: Center(
              child: Container(
                width: 400.w,
                height: 300.h,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 4),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: EdgeInsets.only(top: 20.w, left: 20.r, right: 20.r),
                  child: PageView.builder(
                    onPageChanged: (index) {
                      ctl.currentPageIndex.value = index; // use .value here
                    },
                    itemCount: cards.length,
                    itemBuilder: (context, index) {
                      return GridView.count(
                        childAspectRatio: 1.5.h, // 卡片大小
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 20.h,
                        children: cards[index],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 180.h,
            left: 0.r,
            right: 0.r,
            child: Center(
              child: Obx(
                () => DotsIndicator(
                  dotsCount: cards.length,
                  position: ctl.currentPageIndex.value.toDouble(),
                  decorator: DotsDecorator(
                    activeColor: Colors.black, // 当前页的颜色
                    color: Colors.white, // 其他页的颜色
                    activeSize: Size(10.0.sp, 10.0.sp), // 当前页的大小
                    size: Size(6.0.sp, 6.0.sp), // 其他页的大小
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 80.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.check_circle, size: 50.sp),
                  label: Text('Confirm', style: TextStyle(fontSize: 20.sp)),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFF1A9E2F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // 10像素圆角
                    ),
                  ),
                  onPressed: ctl.confirmAction,
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.cancel, size: 50.sp),
                  label: Text('Cancel', style: TextStyle(fontSize: 20.sp)),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // 10像素圆角
                    ),
                  ),
                  onPressed: ctl.cancel,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
