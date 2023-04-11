import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk/models/department.dart';
import 'package:sdk/models/employe.dart';
import 'package:sdk/models/shop.dart';
import 'package:sdk/views/admin/employes/employe/router.dart';
import 'package:sdk/xcontroller.dart';

import '../../theme.dart';

class DepartmentController extends XController {
  RxBool rxIsloading = false.obs;
  FocusNode nameNode = FocusNode();
  RxList<Employe> rxEmployes = RxList([]);
  Department department;
  DepartmentController(this.department) {
    loadEmployes();
  }

  get nameController => null;
  @override
  void onInit() {
    Shop().loadEmployes().then((list) {
      rxEmployes.addAll(list);
    });
    super.onInit();
  }

  loadEmployes() {
    rxIsloading.value = true;
    rxEmployes.clear();
    Shop().loadEmployes().then((employes) {
      rxEmployes.addAll(employes);
      rxIsloading.value = false;
    }).catchError((e) {
      rxIsloading.value = false;
    });
  }

  newEmploye(List value) async {
    Employe ep = Employe({
      'active': true,
      'shop': Shop().id,
      'value': ['job']
    });
    if (await ep.save() == true) {
      loadEmployes();
    }
  }

    setDepartmentValue(String key, dynamic value, Department department) {
    department[key] = value;
    department.save();
    rxEmployes.refresh();
  }
}
