import 'package:get/get.dart';
import 'package:sdk/models/department.dart';
import 'package:sdk/models/post.dart';
import 'package:sdk/models/shop.dart';
import 'package:sdk/xcontroller.dart';

import 'department/router.dart';

class DepartmentManagerController extends XController {
  RxList<Department> rxDepartments = RxList([]);
  RxBool rxIsloading = false.obs;

  DepartmentManagerController() {
    loadDepartments();
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

  newDepartment() {
    Department department = Department({'active': true, 'shop': Shop().id});
    DepartmentRouter().gotoName('/department', args: {'department': department}).then((value) {
      loadDepartments();
    });
  }

  openDepartment(Department department) {
    DepartmentRouter().gotoName('/department', args: {'department': department}).then((value) {
      loadDepartments();
    });
  }
}
