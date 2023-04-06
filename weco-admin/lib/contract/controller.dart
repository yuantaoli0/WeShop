import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sdk/xcontroller.dart';


class RecentFile {
  final String? icon, name, job, contact, salaire;

  RecentFile({this.icon, this.name, this.job, this.contact, this.salaire});

  get timestamp => null;
}

class ContractController extends XController {
  RxList<RecentFile> rxDemoRecentFiles = RxList([
    RecentFile(
        icon: "assets/icons/setting.svg",
        name: "Yuantao Li",
        job: "产品经理",
        contact: "yuantaoli827@gamil.com",
        salaire: '3000'),
  ]);
  @override
  void onInit() {
    super.onInit();
  }

  newContract() {
    rxDemoRecentFiles.add(RecentFile(
      icon: "assets/icons/setting.svg",
      name: "Yuantao Li",
      job: "产品经理",
      contact: "yuantaoli827@gamil.com",
      salaire: '3000',
    ));
  }
}
