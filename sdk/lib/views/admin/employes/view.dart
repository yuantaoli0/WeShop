import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sdk/language.dart';
import 'package:sdk/xView.dart';
import 'package:sdk/xpage.dart';
import 'package:get/get.dart';
import 'controller.dart';
import 'local.dart';

class View extends XView<EmployeManagerController> {
  View(args, EmployeManagerController ctl, {super.key}) : super(args, ctl) {
    appLanguge.addLocal(XLocal());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('employeManager_title'.tr),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              ctl.newEmploye();
            },
            icon: const Icon(AntDesign.plus),
          )
        ],
      ),
      body: obx(() {
        if (ctl.rxIsloading.value == true) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        } else {
          return obx(
            () => ListView.separated(
                itemBuilder: (ctx, idx) {
                  var ep = ctl.rxEmployes[idx];
                  return InkWell(
                    onTap: () {
                      ctl.openEmploye(ep);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(ep['name'] ?? 'non'),
                    ),
                  );
                },
                separatorBuilder: (ctx, idx) {
                  return const Divider(
                    height: 1,
                  );
                },
                itemCount: ctl.rxEmployes.length),
          );
        }
      }),
    );
  }
}
