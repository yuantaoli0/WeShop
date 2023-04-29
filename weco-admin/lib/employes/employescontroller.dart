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

  List<String> labelText = [
    '姓名',
    '性别',
    '生日',
    '入职时间',
  ];
  List<TextEditingController> textControllers =
      List.generate(4, (index) => TextEditingController());

  RxMap<String, File?> selectedImages = RxMap<String, File?>();

  // void updateImage(String employeId, File newImage, Employe ep) async {
  //   selectedImages[employeId] = newImage;
  //   var res =
  //       await ep.postFile(newImage, '/shop/avatars/uploadImage', 'avatarImage');
  //   print(res);

  //   if (res["status"] == 200) {
  //     String imageUrl = res["data"]["url"];
  //     // 更新UI以显示图片
  //     print(imageUrl);
  //     update();
  //   }
  // }

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

  newEmploye(List<String> inputData) async {
    Employe ep = Employe({
      'active': true,
      'shop': Shop().id,
      'name': inputData[0],
      'sex': inputData[1],
      'birthday': inputData[2],
      'startAt': inputData[3]
    });
    // if (await ep.save() == true) {
    //   loadEmployes();
    // }
    if (await ep.save() == true) {
      loadEmployes();
      // 设置新添加的员工的默认头像
      selectedImages[ep['_id'].toString()] = null;
    }
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
