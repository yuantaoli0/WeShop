import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:sdk/language.dart';
import 'package:sdk/xView.dart';
import 'controller.dart';
import 'local.dart';

class TabletView extends XView<AccountManagerController> {
  TabletView(args, AccountManagerController ctl) : super(args, ctl) {
    appLanguge.addLocal(XLocal());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('accountManager_title'.tr),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(AntDesign.plus),
              onPressed: ctl.newAccount,
            ),
          ],
        ),
        drawer: systemMenuDrawer,
        body: Obx(
          () => ctl.isLoading.value == true
              ? const Center(
                  child: CupertinoActivityIndicator(),
                )
              : Row(
                  children: [
                    Expanded(
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Obx(
                            () => ListView(
                              children: ctl.rxUsers.map<Widget>(
                                (u) {
                                  return Slidable(
                                    //actionPane: SlidableStrechActionPane(),
                                    endActionPane: ActionPane(
                                      extentRatio: 0.75,
                                      motion: const DrawerMotion(),
                                      children: <Widget>[
                                        SlidableAction(
                                          label: 'accountManager_copy'.tr,
                                          backgroundColor: primaryColor(),
                                          //icon: Icons.edit,
                                          icon: Icons.copy,
                                          onPressed: (ctx) async {
                                            ctl.cloneAccount(u);
                                          },
                                        ),
                                      ],
                                    ),
                                    key: Key(u['_id']),
                                    child: InkWell(
                                      onTap: () {
                                        ctl.openAccount(u);
                                      },
                                      key: Key(u['_id']),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              width: 0.5,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(vertical: 10.h),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    u['login'],
                                                    style: const TextStyle(
                                                      //fontWeight: currentAccount == account ? FontWeight.bold : FontWeight.normal,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  Text(
                                                    u['name'] ?? 'Non',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Icon(
                                              u['active'] == true ? Icons.check_circle : Icons.check_circle_outline,
                                              color: Colors.blue,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ));
  }
}
