import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk/models/department.dart';
import 'package:sdk/models/shop.dart';
import 'package:sdk/xcontroller.dart';
import 'package:weco_admin/departments/router.dart';

import '../theme.dart';

class DepartmentsController extends XController {
  RxList<Department> rxDepartments = RxList([]);
  RxBool rxIsloading = false.obs;
  FocusNode nameNode = FocusNode();

  TextEditingController nameController = TextEditingController();

  @override
  void onInit() {
    Shop().loadDartpements().then((list) {
      rxDepartments.addAll(list);
    });
    super.onInit();
  }

  loadDepartments() {
    rxIsloading.value = true;
    rxDepartments.clear();
    Shop().loadDartpements().then((departments) {
      rxDepartments.addAll(departments);
      rxIsloading.value = false;
    }).catchError((e) {
      rxIsloading.value = false;
    });
  }

  newDepartments(String name) async {
    Department department =
        Department({'active': true, 'shop': Shop().id, 'name': name});
    if (await department.save() == true) {
      loadDepartments();
    }
  }

  delDepartments(Department department) async {
    if (await XController.getConfirm(
            title: 'Confirmation', content: 'Vous etes sur?') ==
        true) {
      await department.del();
      rxDepartments.remove(department);
    }
  }

  setDepartmentValue(String key, dynamic value, Department department) {
    department[key] = value;
    department.save();
    rxDepartments.refresh();
  }

  openDepartment(Department department) async {
    DepartmentsRouter().gotoName('/department',
        args: {'department': department},isDialog: false).then((value) {
      loadDepartments();
    });
  }
}
