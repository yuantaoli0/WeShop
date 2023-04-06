import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk/language.dart';
import 'package:sdk/xView.dart';
import 'package:sdk/xpage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'controller.dart';
import 'local.dart';

class TabletView extends XView<TerminalTypeController> {
  TabletView(args, TerminalTypeController ctl) : super(args, ctl) {
    appLanguge.addLocal(XLocal());
  }

  @override
  Widget build(BuildContext context) {
    return XPage(
      appBar: AppBar(
        title: Text(ctl.rxTerminalType.value?['name']),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Text('terminal_type_limit'.tr),
                Expanded(
                  child: obx(
                    () => TextFormField(
                      //autovalidate: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: const TextStyle(fontSize: 14),
                      autocorrect: false,
                      readOnly: ctl.rxIsReadOnly.value,
                      enableSuggestions: false,
                      controller: ctl.limitController,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      onFieldSubmitted: (v) {
                        ctl.setLimit(int.parse(v));
                      },
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        labelText: 'terminal_type_limit'.tr,
                        hintStyle: const TextStyle(fontSize: 14),
                        suffixIcon: InkWell(
                          onTap: ctl.unlock,
                          child: Icon(
                            ctl.rxIsReadOnly.value == true ? Icons.lock : Icons.lock_open,
                            color: primaryColor(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
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
                        'terminal_type_OK'.tr,
                        style: Theme.of(context).primaryTextTheme.headline6?.copyWith(fontSize: 18),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
