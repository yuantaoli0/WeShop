import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sdk/models/department.dart';
import 'package:sdk/models/employe.dart';
import 'package:sdk/models/shop.dart';
import 'package:sdk/xcontroller.dart';

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
    if (await ep.save() == true) {
      loadEmployes();
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
}
