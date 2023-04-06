import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sdk/language.dart';
import 'package:sdk/util/validator.dart';
import 'package:sdk/xView.dart';
import 'package:get/get.dart';
import 'package:sdk/xcontroller.dart';
import 'controller.dart';
import 'local.dart';

class View extends XView<DepartmentController> {
  View(args, DepartmentController ctl, {super.key}) : super(args, ctl) {
    appLanguge.addLocal(XLocal());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('department_title'.tr),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              ctl.delDepartment();
            },
            icon: const Icon(AntDesign.delete),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: ListView(
                children: [
                  TextFormField(
                    controller: ctl.nameController,
                    focusNode: ctl.nameNode,
                    textInputAction: TextInputAction.done,
                    validator: Validator().notEmpty,
                    decoration: InputDecoration(
                      hintText: 'department_name'.tr,
                    ),
                    onChanged: (value) {
                      ctl.setDepartmentValue('name', value);
                    },
                  ),
                  obx(
                    () => Row(
                      children: [
                        Text('department_active'.tr),
                        Switch(
                            value: ctl.rxDepartment.value?['active'] ?? true,
                            onChanged: (v) {
                              ctl.setDepartmentValue('active', v);
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
            width: double.maxFinite,
            child: ElevatedButton(
              child: Text('department_OK'.tr),
              onPressed: () {
                ctl.accept();
              },
            ),
          ),
        ],
      ),
    );
  }
}
