import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sdk/language.dart';
import 'package:sdk/util/validator.dart';
import 'package:sdk/xView.dart';
import 'package:get/get.dart';
import 'package:sdk/xpage.dart';

import 'controller.dart';
import 'local.dart';

class TabletView extends XView<TerminalController> {
  TabletView(args, TerminalController ctl) : super(args, ctl) {
    appLanguge.addLocal(XLocal());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanDown: (_) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: XPage(
        appBar: AppBar(
          title: Text(
            'terminal_title'.tr,
            textAlign: TextAlign.center,
            style: scaffoldTitleStyle()?.copyWith(fontSize: 18),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Form(
                key: ctl.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'terminal_hid'.tr,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                    ),
                    Text(ctl.rxTerminal.value?['hid']),
                    TextFormField(
                      //autovalidate: true,
                      validator: Validator().notEmpty,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: const TextStyle(fontSize: 14),
                      autocorrect: false,
                      enableSuggestions: false,
                      controller: ctl.nameController,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      onChanged: (v) {
                        ctl.setTerminalValue('name', v);
                      },
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        labelText: 'terminal_name'.tr,
                        hintStyle: const TextStyle(fontSize: 14),
                      ),
                    ),
                    /*Container(
                      constraints: BoxConstraints(minHeight: 0.h, maxHeight: 200.h),
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('terminal_services'.tr),
                          SizedBox(
                            height: 300.h,
                            child: Obx(
                              () => ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, idx) {
                                  var q = ctl.rxServices[idx];
                                  bool isSelected = false;
                                  for (var itm in ctl.rxTerminal.value?['cartQueues']) {
                                    if (itm == q['_id']) {
                                      isSelected = true;
                                      break;
                                    }
                                  }
                                  return InkWell(
                                    onTap: () {
                                      ctl.selectService(q);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 10.h),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(q['name']),
                                          Icon(
                                            isSelected ? Icons.check_circle : Icons.check_circle_outline,
                                            color: Colors.blue,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, idx) {
                                  return Divider(
                                    height: 1.h,
                                  );
                                },
                                itemCount: ctl.rxServices.length,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),*/

                    Container(
                      padding: EdgeInsets.symmetric(vertical: 0.h),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'terminal_active'.tr,
                          ),
                          Obx(
                            () => Switch(
                              value: ctl.rxTerminal.value?['active'],
                              activeColor: Colors.blue,
                              onChanged: (v) {
                                ctl.setTerminalValue('active', v);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Theme.of(context).primaryTextTheme.headline6?.color,
                ),
                onPressed: ctl.save,
                child: Obx(
                  () => ctl.isSaving.value == true
                      ? const CupertinoActivityIndicator()
                      : Text(
                          'terminal_OK'.tr,
                          style: Theme.of(context).primaryTextTheme.headline6?.copyWith(fontSize: 18),
                        ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Theme.of(context).primaryTextTheme.headline6?.color,
                ),
                onPressed: ctl.del,
                child: Obx(
                  () => ctl.isSaving.value == true
                      ? const CupertinoActivityIndicator()
                      : Text(
                          'terminal_delete'.tr,
                          style: Theme.of(context).primaryTextTheme.headline6?.copyWith(fontSize: 18),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
