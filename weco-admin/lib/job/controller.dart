import 'dart:ui';

import 'package:get/get.dart';
import 'package:sdk/models/department.dart';
import 'package:sdk/models/shop.dart';
import 'package:sdk/xcontroller.dart';

import '../theme.dart';

class CloudStorageInfo {
  final String? svgSrc, title, time, departemnt;
  final int? count_pepo;
  final Color? color;

  CloudStorageInfo({
    this.svgSrc,
    this.title,
    this.time,
    this.count_pepo,
    this.color,
    this.departemnt,
  });
}

class JobManagementController extends XController {
  RxList<Department> rxDepartments = RxList([]);
  RxList<CloudStorageInfo> rxJobs = RxList([
    CloudStorageInfo(
        title: "职位",
        svgSrc: "assets/icons/job_analysts.svg",
        time: "27/03/2023",
        color: primaryColor,
        count_pepo: 35,
        departemnt: "所在部门"),
  ]);
  @override
  void onInit() {
    Shop().loadDartpements().then((list) {
      rxDepartments.addAll(list);
    });
    super.onInit();
  }

  newJob() {
    rxJobs.add(CloudStorageInfo(
        title: "职位",
        svgSrc: "assets/icons/contract_management.svg",
        time: "27/03/2023",
        color: Color(0xFF007EE5),
        count_pepo: 78,
        departemnt: "所在部门"));
  }
}
