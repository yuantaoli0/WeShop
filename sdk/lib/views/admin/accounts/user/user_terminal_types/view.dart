import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sdk/language.dart';
import 'package:sdk/xView.dart';
import 'package:sdk/xpage.dart';
import 'package:get/get.dart';
import 'controller.dart';
import 'local.dart';

class View extends XView<UserTerminalTypesController> {
  View(args, UserTerminalTypesController ctl) : super(args, ctl) {
    appLanguge.addLocal(XLocal());
  }

  @override
  Widget build(BuildContext context) {
    return XPage(
      appBar: AppBar(
        title: Text(
          'user_terminal_types_title'.tr,
          style: scaffoldTitleStyle()?.copyWith(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: obx(() => ListView.separated(
                  itemBuilder: (ctx, idx) {
                    var tt = ctl.rxTerminalTypes[idx];
                    bool isSelected = ctl.rxSelectedTypes.contains(tt['_id']);

                    return InkWell(
                      onTap: () {
                        ctl.selectTyperminalType(tt);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(tt['name']),
                            Icon(
                              isSelected ? Icons.check_circle : Icons.check_circle_outline,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (cxt, idx) {
                    return Divider(
                      height: 1.h,
                    );
                  },
                  itemCount: ctl.rxTerminalTypes.length,
                )),
          ),
          SizedBox(
            height: 40,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Theme.of(context).primaryTextTheme.headline6?.color,
              ),
              onPressed: ctl.accept,
              child: Text(
                'user_terminal_types_OK'.tr,
                //style: Theme.of(context).primaryTextTheme.headline6?.copyWith(fontSize: ScreenUtil().setSp(18)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
