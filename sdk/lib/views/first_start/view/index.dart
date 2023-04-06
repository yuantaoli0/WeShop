import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk/views/first_start/controller.dart';
import 'package:sdk/xView.dart';
import 'package:sdk/xpage.dart';

import 'company_info.dart';
import 'confirm.dart';
import 'root_user.dart';

class FirstStartView extends XView<FirstStartController> {
  FirstStartView(args, ctl, {super.key}) : super(args, ctl);

  @override
  Widget build(BuildContext context) {
    return XPage(
      appBar: AppBar(
        title: Obx(
          () => Text(
            ctl.titles[ctl.rxCurrentPageIndex.value],
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: PageView.builder(
          controller: ctl.pageController,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          //onPageChanged: ctl.changePage,
          itemBuilder: (context, idx) {
            if (idx == 0) {
              return RootUserView(ctl);
            } else if (idx == 1) {
              return CompanyInfoView(ctl);
            } else {
              return ConfirmView(ctl);
            }
          }),
    );
  }
}
