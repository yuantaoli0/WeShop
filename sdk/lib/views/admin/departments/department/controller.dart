import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk/models/department.dart';
import 'package:sdk/models/employe.dart';
import 'package:sdk/util/format.dart';
import 'package:sdk/xcontroller.dart';

class DepartmentController extends XController {
  Rx<Department?> rxDepartment = Rx(null);
  TextEditingController nameController = TextEditingController();
  FocusNode nameNode = FocusNode();

  DepartmentController(Department department) {
    rxDepartment.value = department;
    nameController.text = department['name'] ?? '';
  }

  @override
  void accept() async {
    var r = await rxDepartment.value?.save();
    if (r == true) {
      super.accept();
    }
  }

  delDepartment() async {
    if (await XController.getConfirm(title: 'Confirmation', content: 'Vous etes sur?') == true) {
      await rxDepartment.value?.del();
      close(false);
    }
  }

  setDepartmentValue(String key, dynamic value) {
    rxDepartment.value?[key] = value;
    rxDepartment.refresh();
  }
}
