import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sdk/models/department.dart';
import 'package:sdk/models/employe.dart';
import 'package:sdk/models/shop.dart';
import 'package:sdk/xcontroller.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class EmployesController extends XController {
  RxList<Employe> rxEmployes = RxList([]);
  RxBool rxIsloading = false.obs;

  newEmploye(List<String> inputData) async {
    Employe ep = Employe({
      'active': true,
      'shop': Shop().id,
      'name': inputData[0],
      'sex': inputData[1],
      'birthday': inputData[2],
      'nationality': inputData[3],
      'cardNumber': inputData[4],
      'address': inputData[5],
      'postCode': inputData[6],
      'city': inputData[7],
      'telephone': inputData[8],
      'socialSecurityNumber': inputData[9],
      'salary': inputData[10],
      'vacationDays': inputData[11],
      'createdAt': inputData[12],
      'startAt': inputData[13],
      'endedAt': inputData[14],
      'comment': inputData[15],
    });
    if (await ep.save() == true) {
      loadEmployes();
      // 设置新添加的员工的默认头像
      selectedImages[ep['_id'].toString()] = null;
    }
  }

  List<String> labelText = [
    '姓名',
    '性别',
    '生日',
    '国籍',
    '卡号',
    '地址',
    '邮编',
    '城市',
    '电话号码',
    '社会保险号码',
    '工资',
    '假期天数',
    '创建时间',
    '开始时间',
    '结束时间',
    '评价',
  ];
  List<TextEditingController> textControllers =
      List.generate(16, (index) => TextEditingController());

  // '姓名',
  // '性别',
  // '生日',
  // '国籍'
  // '卡号',
  // '地址',
  // '邮编',
  // '城市',
  // '电话号码',
  // '合同类型',
  // '商店名称',
  // '岗位',
  // '社会保险号码',
  // '工资',
  // '工资历史',
  // '假期天数',
  // '合同文件pdf',
  // '工作时间',
  // '创建时间',
  // '活动',
  // '开始时间',
  // '结束时间',
  // '评价',
  // '入职时间',
  // '辞职时间',
  List<TextEditingController> EptextControllers =
      List.generate(16, (index) => TextEditingController());

  RxMap<String, File?> selectedImages = RxMap<String, File?>();

  void updateImage(String employeId, File newImage, Employe ep) async {
    selectedImages[employeId] = newImage;
    var res =
        await ep.postFile(newImage, '/shop/avatars/uploadImage', 'avatarImage');
    print(res);

    if (res["status"] == 200) {
      String imageUrl = res["data"]["url"];
      ep['avatarUrl'] = imageUrl; // 更新Employe模型的files
      if (await ep.save() == true) {
        // loadEmployes();
      }
      update();
    }
  }

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

  delEmploye(Employe ep) async {
    if (await XController.getConfirm(
            title: 'Confirmation', content: 'Vous etes sur?') ==
        true) {
      await ep.del();
      rxEmployes.remove(ep);
      close(false);
    }
  }

  uploadImage(Employe ep, File image) async {
    var res =
        await ep.postFile(image, '/shop/avatars/uploadImage', 'avatarImage');
  }
}
