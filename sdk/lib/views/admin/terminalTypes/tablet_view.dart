import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sdk/language.dart';
import 'package:sdk/models/terminal.dart';
import 'package:sdk/util/format.dart';
import 'package:sdk/xView.dart';
import 'package:get/get.dart';

import 'controller.dart';
import 'local.dart';

class TabletView extends XView<TerminalTypeManagerController> {
  TabletView(args, TerminalTypeManagerController ctl) : super(args, ctl) {
    appLanguge.addLocal(XLocal());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('terminalTypeManager_title'.tr),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                ctl.openTerminalTypeConfig();
              },
              icon: const Icon(AntDesign.setting))
        ],
      ),
      drawer: systemMenuDrawer,
      body: ctl.isLoading.value == true
          ? const Center(child: CupertinoActivityIndicator())
          : Card(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Obx(
                  () => ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (ctx, idx) {
                      //var tt = controller.rxTerminalTypes[controller.rxCurrentTabIndex.value];
                      var t = ctl.rxTerminals[idx];
                      return InkWell(
                        onTap: () {
                          ctl.openTerminal(t);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    t['name'] + (t['hid'] == Terminal.currentTerminal!['hid'] ? '(${'teminalTypeManager_thisMachine'.tr})' : ''),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        t['hid'],
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                                      ),
                                      Text(
                                        t['createdAt'] == null ? '' : format.date(t['createdAt'])!,
                                        style: const TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Icon(
                                t['active'] == true ? Icons.check_circle : Icons.check_circle_outline,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (ctx, idx) {
                      return Divider(height: 1.h);
                    },
                    itemCount: ctl.rxTerminals.length,
                  ),
                ),
              ),
            ),
      bottomNavigationBar: Obx(
        () => ctl.rxTerminalTypes.length <= 1
            ? const SizedBox.shrink()
            : BottomNavigationBar(
                elevation: 2,
                type: BottomNavigationBarType.fixed,
                items: ctl.rxTerminalTypes
                    .map<BottomNavigationBarItem>(
                      (tt) => BottomNavigationBarItem(
                        label: tt['name'],
                        icon: const Icon(Entypo.tablet_mobile_combo),
                      ),
                    )
                    .toList(),
                currentIndex: ctl.rxCurrentTabIndex.value,
                onTap: ctl.changeTab,
              ),
      ),
    );
  }
}
