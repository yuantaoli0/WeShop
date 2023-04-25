import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sdk/models/department.dart';
import 'package:sdk/models/employe.dart';
import 'package:sdk/models/shop.dart';
import 'package:sdk/xcontroller.dart';

// class RecentFile {
//   final String? icon, name, job, contact, salaire;

//   RecentFile({this.icon, this.name, this.job, this.contact, this.salaire});

//   get timestamp => null;
// }

class EmployesController extends XController {
  RxList<Employe> rxEmployes = RxList([]);
  RxBool rxIsloading = false.obs;

  // Department department;

  @override
  void onInit() {
    Shop().loadDartpements().then((list) {
      rxEmployes.addAll(list as Iterable<Employe>);
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

  newEmploye(String name) async {
    Employe ep = Employe({'active': true, 'shop': Shop().id, 'name': name});
    if (await ep.save() == true) {
      loadEmployes();
    }
  }

  // RxList<RecentFile> rxDemoRecentFiles = RxList([
  //   RecentFile(
  //       icon: "assets/icons/setting.svg",
  //       name: "Yuantao Li",
  //       job: "产品经理",
  //       contact: "yuantaoli827@gamil.com",
  //       salaire: '3000'),
  // ]);
  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // newContract() {
  //   rxDemoRecentFiles.add(RecentFile(
  //     icon: "assets/icons/setting.svg",
  //     name: "Yuantao Li",
  //     job: "产品经理",
  //     contact: "yuantaoli827@gamil.com",
  //     salaire: '3000',
  //   ));
  // }
}
